#!/usr/bin/env python3
# backend Flask per il registro asset NIS2 - Prima Industrie S.p.A.
# project work L-31, Informatica per le Aziende Digitali - Pegaso
#
# gestisce le pagine CRUD per asset, fornitori, responsabili,
# referenti ACN e la consultazione del catalogo controlli.
# usa Flask + psycopg2, template Jinja2 nella cartella frontend/

import os
import psycopg2
import psycopg2.extras          # per DictCursor: restituisce righe come dizionari
from flask import Flask, render_template, request, redirect, url_for, flash

# se esiste DATABASE_URL (Render ce la passa come variabile d'ambiente)
# usiamo quella, altrimenti i parametri locali per sviluppo
DATABASE_URL = os.environ.get("DATABASE_URL")

# parametri connessione al db locale (fallback per sviluppo)
DB_CONFIG = {
    "host":     "localhost",
    "port":     5432,
    "dbname":   "nis2_pw_schembri",
    "user":     "postgres",
    "password": "postgres"
}

# i template html stanno nella cartella frontend/ che è allo stesso livello di backend/
app = Flask(__name__, template_folder="../frontend")
app.secret_key = os.environ.get("SECRET_KEY", "nis2_prima_industrie_dev")


def get_db():
    # apre una connessione nuova ad ogni richiesta - semplice ma funziona
    # per un'applicazione con pochi utenti va benissimo
    if DATABASE_URL:
        conn = psycopg2.connect(DATABASE_URL)
    else:
        conn = psycopg2.connect(**DB_CONFIG)
    return conn


# ---- PROFILO AZIENDA ----
# pagina per configurare i dati dell'organizzazione
# e calcolare se è soggetto "importante" o "essenziale"
# secondo l'art. 3 del D.Lgs. 138/2024

# settori dell'Allegato I NIS2 (alta criticità → possibile essenziale)
SETTORI_ALLEGATO_I = {
    "Energia", "Trasporti", "Settore bancario",
    "Infrastrutture dei mercati finanziari", "Settore sanitario",
    "Acqua potabile", "Acque reflue", "Infrastrutture digitali",
    "Gestione dei servizi TIC", "Pubblica amministrazione", "Spazio"
}


def calcola_classificazione(settore, fatturato, dipendenti, infra_critica):
    """Determina se l'organizzazione è soggetto essenziale o importante.

    Logica semplificata basata sull'art. 3 del D.Lgs. 138/2024:
    - Essenziale: settore Allegato I E (fatturato >= 50M o dipendenti >= 250)
                  oppure infrastruttura critica designata
    - Importante: tutti gli altri nel perimetro NIS2
    """
    if infra_critica:
        return "essenziale"
    if settore in SETTORI_ALLEGATO_I:
        if (fatturato and fatturato >= 50) or (dipendenti and dipendenti >= 250):
            return "essenziale"
    return "importante"


@app.route("/profilo", methods=["GET", "POST"])
def profilo_azienda():
    """Form per configurare il profilo azienda e calcolare la classificazione NIS2."""
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    if request.method == "POST":
        ragione_sociale    = request.form["ragione_sociale"].strip()
        settore            = request.form["settore"]
        sotto_settore      = request.form.get("sotto_settore", "").strip() or None
        fatturato          = float(request.form["fatturato_milioni"])
        dipendenti         = int(request.form["num_dipendenti"])
        infra_critica      = "infrastruttura_critica" in request.form

        classificazione = calcola_classificazione(settore, fatturato, dipendenti, infra_critica)

        # upsert: inserisce se non esiste, aggiorna se esiste (id_profilo = 1 sempre)
        cur.execute("""
            INSERT INTO profilo_azienda
                (id_profilo, ragione_sociale, settore, sotto_settore,
                 fatturato_milioni, num_dipendenti, infrastruttura_critica,
                 classificazione, data_aggiornamento)
            VALUES (1, %s, %s, %s, %s, %s, %s, %s, NOW())
            ON CONFLICT (id_profilo) DO UPDATE SET
                ragione_sociale = EXCLUDED.ragione_sociale,
                settore = EXCLUDED.settore,
                sotto_settore = EXCLUDED.sotto_settore,
                fatturato_milioni = EXCLUDED.fatturato_milioni,
                num_dipendenti = EXCLUDED.num_dipendenti,
                infrastruttura_critica = EXCLUDED.infrastruttura_critica,
                classificazione = EXCLUDED.classificazione,
                data_aggiornamento = NOW()
        """, (ragione_sociale, settore, sotto_settore, fatturato,
              dipendenti, infra_critica, classificazione))
        conn.commit()
        flash(f"Profilo salvato. Classificazione: soggetto {classificazione}.", "success")
        cur.close()
        conn.close()
        return redirect(url_for("profilo_azienda"))

    # GET: carica il profilo esistente (se c'è)
    cur.execute("SELECT * FROM profilo_azienda WHERE id_profilo = 1")
    profilo = cur.fetchone()
    cur.close()
    conn.close()
    return render_template("profilo_azienda.html", profilo=profilo)


# ---- HOME ----

@app.route("/")
def index():
    """Dashboard - mostra i contatori principali e il profilo azienda."""
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    # carico il profilo per mostrare la classificazione in dashboard
    cur.execute("SELECT * FROM profilo_azienda WHERE id_profilo = 1")
    profilo = cur.fetchone()

    # contatori per le card della dashboard
    cur.execute("SELECT COUNT(*) FROM asset")
    num_asset = cur.fetchone()[0]

    cur.execute("SELECT COUNT(*) FROM asset WHERE criticita = 'alto'")
    num_critici = cur.fetchone()[0]

    cur.execute("SELECT COUNT(*) FROM fornitore")
    num_fornitori = cur.fetchone()[0]

    # quanti controlli ACN abbiamo marcato come implementati
    cur.execute("SELECT COUNT(*) FROM controllo_status WHERE status = 'implementato'")
    num_implementati = cur.fetchone()[0]

    cur.execute("SELECT COUNT(*) FROM controllo")
    num_controlli = cur.fetchone()[0]

    cur.execute("SELECT COUNT(*) FROM controllo_status WHERE status = 'non_implementato'")
    num_non_implementati = cur.fetchone()[0]

    cur.close()
    conn.close()

    return render_template(
        "index.html",
        profilo=profilo,
        num_asset=num_asset,
        num_critici=num_critici,
        num_fornitori=num_fornitori,
        num_implementati=num_implementati,
        num_controlli=num_controlli,
        num_non_implementati=num_non_implementati
    )


# ---- ASSET ----

@app.route("/asset")
def asset_lista():
    """Elenco di tutti gli asset con responsabile."""
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    # join con responsabile per mostrare il nome completo nella tabella
    # ordino per criticità decrescente: prima gli asset più critici
    cur.execute("""
        SELECT a.id_asset, a.nome, a.tipo, a.sistema_operativo,
               a.criticita, r.nome || ' ' || r.cognome AS responsabile
        FROM asset a
        JOIN responsabile r ON a.id_responsabile = r.id_responsabile
        ORDER BY a.criticita DESC, a.nome
    """)
    asset_rows = cur.fetchall()
    cur.close()
    conn.close()
    return render_template("asset_lista.html", asset_rows=asset_rows)


@app.route("/asset/<int:id_asset>")
def asset_dettaglio(id_asset):
    """Dettaglio di un singolo asset con servizi, fornitori e storico."""
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    cur.execute("""
        SELECT a.*, r.nome || ' ' || r.cognome AS nome_responsabile,
               r.email AS email_responsabile
        FROM asset a
        JOIN responsabile r ON a.id_responsabile = r.id_responsabile
        WHERE a.id_asset = %s
    """, (id_asset,))
    asset = cur.fetchone()

    if asset is None:
        flash("Asset non trovato.", "danger")
        return redirect(url_for("asset_lista"))

    # servizi collegati a questo asset (relazione N:M tramite asset_servizio)
    cur.execute("""
        SELECT s.nome, s.descrizione
        FROM servizio s
        JOIN asset_servizio ase ON s.id_servizio = ase.id_servizio
        WHERE ase.id_asset = %s
        ORDER BY s.nome
    """, (id_asset,))
    servizi = cur.fetchall()

    # fornitori collegati (stessa logica, tabella ponte asset_fornitore)
    cur.execute("""
        SELECT f.ragione_sociale, f.tipo_fornitura,
               f.livello_accesso, f.impatto_interruzione,
               f.referente_nome, f.referente_email
        FROM fornitore f
        JOIN asset_fornitore af ON f.id_fornitore = af.id_fornitore
        WHERE af.id_asset = %s
        ORDER BY f.ragione_sociale
    """, (id_asset,))
    fornitori = cur.fetchall()

    cur.execute("""
        SELECT snapshot, data_modifica, motivo_modifica
        FROM asset_version
        WHERE id_asset = %s
        ORDER BY data_modifica DESC
    """, (id_asset,))
    storico = cur.fetchall()

    cur.close()
    conn.close()
    return render_template(
        "asset_dettaglio.html",
        asset=asset,
        servizi=servizi,
        fornitori=fornitori,
        storico=storico
    )


@app.route("/asset/nuovo", methods=["GET", "POST"])
def asset_nuovo():
    """Form per inserire un nuovo asset."""
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute("SELECT id_responsabile, nome || ' ' || cognome AS nome FROM responsabile ORDER BY cognome")
    responsabili = cur.fetchall()

    if request.method == "POST":
        nome = request.form["nome"].strip()
        tipo = request.form["tipo"]
        sistema_operativo = request.form["sistema_operativo"].strip() or None
        descrizione = request.form["descrizione"].strip()
        criticita = request.form["criticita"]
        id_responsabile = int(request.form["id_responsabile"])

        if not nome or not descrizione:
            flash("Nome e descrizione sono obbligatori.", "danger")
        else:
            cur.execute("""
                INSERT INTO asset (nome, tipo, sistema_operativo, descrizione, criticita, id_responsabile)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (nome, tipo, sistema_operativo, descrizione, criticita, id_responsabile))
            conn.commit()
            flash("Asset inserito con successo.", "success")
            cur.close()
            conn.close()
            return redirect(url_for("asset_lista"))

    cur.close()
    conn.close()
    return render_template("asset_form.html", asset=None, responsabili=responsabili)


@app.route("/asset/<int:id_asset>/modifica", methods=["GET", "POST"])
def asset_modifica(id_asset):
    """Form per modificare un asset esistente."""
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    cur.execute("SELECT * FROM asset WHERE id_asset = %s", (id_asset,))
    asset = cur.fetchone()
    if asset is None:
        flash("Asset non trovato.", "danger")
        return redirect(url_for("asset_lista"))

    cur.execute("SELECT id_responsabile, nome || ' ' || cognome AS nome FROM responsabile ORDER BY cognome")
    responsabili = cur.fetchall()

    if request.method == "POST":
        nome = request.form["nome"].strip()
        tipo = request.form["tipo"]
        sistema_operativo = request.form["sistema_operativo"].strip() or None
        descrizione = request.form["descrizione"].strip()
        criticita = request.form["criticita"]
        id_responsabile = int(request.form["id_responsabile"])
        motivo = request.form.get("motivo_modifica", "").strip() or None

        if not nome or not descrizione:
            flash("Nome e descrizione sono obbligatori.", "danger")
        else:
            # l'UPDATE fa scattare il trigger salva_versione_asset
            # che salva una copia del record prima della modifica
            cur.execute("""
                UPDATE asset
                SET nome = %s, tipo = %s, sistema_operativo = %s,
                    descrizione = %s, criticita = %s, id_responsabile = %s
                WHERE id_asset = %s
            """, (nome, tipo, sistema_operativo, descrizione, criticita, id_responsabile, id_asset))

            if motivo:
                cur.execute("""
                    UPDATE asset_version
                    SET motivo_modifica = %s
                    WHERE id_version = (
                        SELECT id_version FROM asset_version
                        WHERE id_asset = %s
                        ORDER BY data_modifica DESC
                        LIMIT 1
                    )
                """, (motivo, id_asset))

            conn.commit()
            flash("Asset aggiornato con successo.", "success")
            cur.close()
            conn.close()
            return redirect(url_for("asset_dettaglio", id_asset=id_asset))

    cur.close()
    conn.close()
    return render_template("asset_form.html", asset=asset, responsabili=responsabili)


@app.route("/asset/<int:id_asset>/elimina", methods=["POST"])
def asset_elimina(id_asset):
    """Elimina un asset (solo via POST per sicurezza)."""
    conn = get_db()
    cur = conn.cursor()
    # bisogna cancellare prima le righe figlie sennò PostgreSQL
    # blocca tutto per violazione delle foreign key
    cur.execute("DELETE FROM asset_servizio WHERE id_asset = %s", (id_asset,))
    cur.execute("DELETE FROM asset_fornitore WHERE id_asset = %s", (id_asset,))
    cur.execute("DELETE FROM asset_version WHERE id_asset = %s", (id_asset,))
    cur.execute("DELETE FROM asset WHERE id_asset = %s", (id_asset,))
    conn.commit()
    cur.close()
    conn.close()
    flash("Asset eliminato.", "warning")
    return redirect(url_for("asset_lista"))


# ---- FORNITORI ----

@app.route("/fornitori")
def fornitori_lista():
    """Elenco di tutti i fornitori."""
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute("""
        SELECT id_fornitore, ragione_sociale, tipo_fornitura,
               livello_accesso, impatto_interruzione, referente_nome
        FROM fornitore
        ORDER BY ragione_sociale
    """)
    fornitori = cur.fetchall()
    cur.close()
    conn.close()
    return render_template("fornitori_lista.html", fornitori=fornitori)


@app.route("/fornitori/nuovo", methods=["GET", "POST"])
def fornitore_nuovo():
    """Form per inserire un nuovo fornitore."""
    if request.method == "POST":
        ragione_sociale   = request.form["ragione_sociale"].strip()
        referente_nome    = request.form["referente_nome"].strip()
        referente_email   = request.form["referente_email"].strip()
        tipo_fornitura    = request.form["tipo_fornitura"].strip()
        livello_accesso   = request.form["livello_accesso"]
        impatto           = request.form["impatto_interruzione"]

        if not ragione_sociale or not referente_email:
            flash("Ragione sociale e email referente sono obbligatorie.", "danger")
        else:
            conn = get_db()
            cur = conn.cursor()
            cur.execute("""
                INSERT INTO fornitore (ragione_sociale, referente_nome, referente_email,
                                       tipo_fornitura, livello_accesso, impatto_interruzione)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (ragione_sociale, referente_nome, referente_email, tipo_fornitura, livello_accesso, impatto))
            conn.commit()
            cur.close()
            conn.close()
            flash("Fornitore inserito con successo.", "success")
            return redirect(url_for("fornitori_lista"))

    return render_template("fornitore_form.html", fornitore=None)


@app.route("/fornitori/<int:id_fornitore>/modifica", methods=["GET", "POST"])
def fornitore_modifica(id_fornitore):
    """Form per modificare un fornitore esistente."""
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute("SELECT * FROM fornitore WHERE id_fornitore = %s", (id_fornitore,))
    fornitore = cur.fetchone()
    if fornitore is None:
        flash("Fornitore non trovato.", "danger")
        return redirect(url_for("fornitori_lista"))

    if request.method == "POST":
        ragione_sociale = request.form["ragione_sociale"].strip()
        referente_nome  = request.form["referente_nome"].strip()
        referente_email = request.form["referente_email"].strip()
        tipo_fornitura  = request.form["tipo_fornitura"].strip()
        livello_accesso = request.form["livello_accesso"]
        impatto         = request.form["impatto_interruzione"]

        cur.execute("""
            UPDATE fornitore
            SET ragione_sociale = %s, referente_nome = %s, referente_email = %s,
                tipo_fornitura = %s, livello_accesso = %s, impatto_interruzione = %s
            WHERE id_fornitore = %s
        """, (ragione_sociale, referente_nome, referente_email,
              tipo_fornitura, livello_accesso, impatto, id_fornitore))
        conn.commit()
        flash("Fornitore aggiornato.", "success")
        cur.close()
        conn.close()
        return redirect(url_for("fornitori_lista"))

    cur.close()
    conn.close()
    return render_template("fornitore_form.html", fornitore=fornitore)


# ---- RESPONSABILI ----

@app.route("/responsabili")
def responsabili_lista():
    """Elenco responsabili interni."""
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    # LEFT JOIN per contare quanti asset ha ogni responsabile
    # (se ne ha zero viene comunque mostrato grazie al LEFT)
    cur.execute("""
        SELECT r.id_responsabile, r.nome, r.cognome, r.email,
               r.ruolo, r.telefono,
               COUNT(a.id_asset) AS num_asset
        FROM responsabile r
        LEFT JOIN asset a ON r.id_responsabile = a.id_responsabile
        GROUP BY r.id_responsabile
        ORDER BY r.cognome
    """)
    responsabili = cur.fetchall()
    cur.close()
    conn.close()
    return render_template("responsabili_lista.html", responsabili=responsabili)


@app.route("/responsabili/nuovo", methods=["GET", "POST"])
def responsabile_nuovo():
    """Form per inserire un nuovo responsabile."""
    if request.method == "POST":
        nome     = request.form["nome"].strip()
        cognome  = request.form["cognome"].strip()
        email    = request.form["email"].strip()
        ruolo    = request.form["ruolo"].strip()
        telefono = request.form.get("telefono", "").strip() or None

        if not nome or not cognome or not email or not ruolo:
            flash("Nome, cognome, email e ruolo sono obbligatori.", "danger")
        else:
            conn = get_db()
            cur = conn.cursor()
            cur.execute("""
                INSERT INTO responsabile (nome, cognome, email, ruolo, telefono)
                VALUES (%s, %s, %s, %s, %s)
            """, (nome, cognome, email, ruolo, telefono))
            conn.commit()
            cur.close()
            conn.close()
            flash("Responsabile inserito con successo.", "success")
            return redirect(url_for("responsabili_lista"))

    return render_template("responsabile_form.html")


# ---- REFERENTI ACN ----

@app.route("/referenti-acn")
def referenti_acn_lista():
    """Lista dei tre referenti ACN dell'organizzazione."""
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute("""
        SELECT id_referente, nome, cognome, email, telefono, ruolo
        FROM referente_acn
        ORDER BY ruolo
    """)
    referenti = cur.fetchall()
    cur.close()
    conn.close()
    return render_template("referenti_acn.html", referenti=referenti)


@app.route("/referenti-acn/<int:id_referente>/modifica", methods=["GET", "POST"])
def referente_acn_modifica(id_referente):
    """Modifica i dati di un referente ACN."""
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute("SELECT * FROM referente_acn WHERE id_referente = %s", (id_referente,))
    referente = cur.fetchone()

    if referente is None:
        flash("Referente non trovato.", "danger")
        return redirect(url_for("referenti_acn_lista"))

    if request.method == "POST":
        nome     = request.form["nome"].strip()
        cognome  = request.form["cognome"].strip()
        email    = request.form["email"].strip()
        telefono = request.form["telefono"].strip()

        cur.execute("""
            UPDATE referente_acn
            SET nome = %s, cognome = %s, email = %s, telefono = %s
            WHERE id_referente = %s
        """, (nome, cognome, email, telefono, id_referente))
        conn.commit()
        flash("Referente ACN aggiornato.", "success")
        cur.close()
        conn.close()
        return redirect(url_for("referenti_acn_lista"))

    cur.close()
    conn.close()
    return render_template("referente_acn_form.html", referente=referente)


# ---- CATALOGO ACN ----

@app.route("/acn")
def acn_lista():
    """Vista del catalogo ACN con requirements, controlli e status.
    Legge il profilo azienda per filtrare automaticamente i controlli
    in base alla classificazione (importante/essenziale)."""
    # il filtro categoria arriva come parametro GET dalla dropdown nel template
    categoria_filtro = request.args.get("categoria", "")

    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    # leggo il profilo per determinare il filtro corretto
    cur.execute("SELECT classificazione FROM profilo_azienda WHERE id_profilo = 1")
    profilo = cur.fetchone()
    classificazione = profilo["classificazione"] if profilo else "importante"

    # costruisco la query pezzo per pezzo con i filtri dinamici
    query = """
        SELECT r.codice          AS codice_requirement,
               r.categoria,
               r.descrizione     AS desc_requirement,
               c.id_controllo,
               c.numero          AS numero_controllo,
               c.testo           AS testo_controllo,
               cs.status         AS status_implementazione,
               cs.note,
               cs.data_aggiornamento,
               r.applicabile_importanti,
               r.applicabile_essenziali
        FROM requirement r
        JOIN controllo c         ON r.id_requirement = c.id_requirement
        JOIN controllo_status cs ON c.id_controllo   = cs.id_controllo
        WHERE 1=1
    """
    params = []

    if categoria_filtro:
        query += " AND r.categoria = %s"
        params.append(categoria_filtro)

    # filtra i controlli in base alla classificazione del profilo
    if classificazione == "essenziale":
        query += " AND r.applicabile_essenziali = TRUE"
    else:
        query += " AND r.applicabile_importanti = TRUE"

    query += " ORDER BY r.categoria, r.codice, c.numero"

    cur.execute(query, params)
    controlli = cur.fetchall()
    cur.close()
    conn.close()

    return render_template(
        "acn_lista.html",
        controlli=controlli,
        categoria_filtro=categoria_filtro,
        classificazione=classificazione
    )


@app.route("/acn/controllo/<int:id_controllo>/status", methods=["POST"])
def acn_aggiorna_status(id_controllo):
    """Aggiorna lo status di un controllo ACN."""
    nuovo_status = request.form["status"]
    nota         = request.form.get("note", "").strip() or None

    conn = get_db()
    cur = conn.cursor()
    # il trigger aggiorna_data_status scatta automaticamente
    # e imposta data_aggiornamento = NOW()
    cur.execute("""
        UPDATE controllo_status
        SET status = %s, note = %s
        WHERE id_controllo = %s
    """, (nuovo_status, nota, id_controllo))
    conn.commit()
    cur.close()
    conn.close()
    flash("Status controllo aggiornato.", "success")
    return redirect(url_for("acn_lista"))


if __name__ == "__main__":
    # host 0.0.0.0 per rendere il server visibile anche da altri dispositivi in LAN
    # debug=True è comodo in sviluppo, mostra il traceback direttamente nel browser
    app.run(debug=True, host="0.0.0.0", port=5000)
