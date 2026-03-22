#!/usr/bin/env python3
# genera_seed_acn.py
# legge i due file Excel ufficiali ACN (Allegato 1 e Allegato 2)
# e genera il file database/seed_acn.sql con tutti gli INSERT
#
# fonte: https://www.acn.gov.it/portale/nis/modalita-specifiche-base
# i file vanno scaricati e rinominati:
#   allegato1_importanti.xlsx  (soggetti importanti)
#   allegato2_essenziali.xlsx  (soggetti essenziali)
#
# struttura xlsx (una riga = un controllo):
#   col A: funzione  (GV, ID, PR, DE, RS, RC)
#   col B: categoria (GV.OC, GV.RM, ...)
#   col C: codice    (GV.OC-04, ...)
#   col D: descrizione del requirement
#   col E: numero punto del controllo
#   col F: testo del controllo
#
# dipendenze: openpyxl (pip install openpyxl)
# output: ../database/seed_acn.sql

import os
import re
import openpyxl

# percorsi file - i due xlsx devono stare nella cartella radice del progetto

SCRIPT_DIR    = os.path.dirname(os.path.abspath(__file__))
XLSX_IMP      = os.path.join(SCRIPT_DIR, "..", "allegato1_importanti.xlsx")
XLSX_ESS      = os.path.join(SCRIPT_DIR, "..", "allegato2_essenziali.xlsx")
OUTPUT_SQL    = os.path.join(SCRIPT_DIR, "..", "database", "seed_acn.sql")

# riga 1 = titolo, riga 2 = intestazioni colonne, dati dalla 3 in poi
RIGA_DATI     = 3

# mappa la sigla della funzione (colonna A) al valore ENUM del db
MAPPA_FUNZIONE = {
    "GV": "GOVERN",
    "ID": "IDENTIFY",
    "PR": "PROTECT",
    "DE": "DETECT",
    "RS": "RESPOND",
    "RC": "RECOVER",
}


def pulisci(testo):
    # ho scoperto che nei file xlsx dell'ACN ci sono un sacco di \xa0
    # (non-breaking space) al posto degli spazi normali, e in SQL danno
    # problemi perché non sono lo stesso carattere
    if testo is None:
        return ""
    return str(testo).replace("\xa0", " ").strip()


def escape_sql(testo):
    # l'apostrofo in SQL va raddoppiato per fare l'escape
    return testo.replace("'", "''")


def leggi_xlsx(percorso, applicabile_importanti, applicabile_essenziali):
    """
    Legge il foglio 'Misure di sicurezza' del file XLSX e restituisce
    un dizionario requirements e una lista di controlli.

    Struttura restituita:
      requirements = {
        "GV.OC-04": {
          "codice": "GV.OC-04",
          "categoria": "GOVERN",
          "descrizione": "...",
          "applicabile_importanti": True/False,
          "applicabile_essenziali": True/False,
        },
        ...
      }
      controlli = [
        {"codice_req": "GV.OC-04", "numero": 1, "testo": "..."},
        ...
      ]
    """
    wb = openpyxl.load_workbook(percorso)
    ws = wb["Misure di sicurezza"]

    requirements = {}
    controlli = []

    for riga in ws.iter_rows(min_row=RIGA_DATI, values_only=True):
        funzione   = pulisci(riga[0])
        codice     = pulisci(riga[2])
        descrizione = pulisci(riga[3])
        numero     = riga[4]
        testo      = pulisci(riga[5])

        # Salta righe vuote o senza codice
        if not codice or not funzione:
            continue

        # verifica formato tipo GV.OC-04 (2 lettere, punto, 2 lettere, trattino, 2 cifre)
        if not re.match(r'^[A-Z]{2}\.[A-Z]{2}-\d{2}$', codice):
            continue

        categoria = MAPPA_FUNZIONE.get(funzione, "GOVERN")

        # Aggiunge il requirement se non gia' presente
        if codice not in requirements:
            requirements[codice] = {
                "codice":                 codice,
                "categoria":              categoria,
                "descrizione":            descrizione,
                "applicabile_importanti": applicabile_importanti,
                "applicabile_essenziali": applicabile_essenziali,
            }

        # Aggiunge il controllo (numero + testo)
        if numero is not None and testo:
            controlli.append({
                "codice_req": codice,
                "numero":     int(numero),
                "testo":      testo,
            })

    return requirements, controlli


def genera_sql(requirements_imp, controlli_imp,
               requirements_ess, controlli_ess):
    """
    Unisce i dati dei due allegati e genera il contenuto SQL.

    Logica di unione:
    - Se un requirement e' in entrambi gli allegati:
        applicabile_importanti = TRUE, applicabile_essenziali = TRUE
    - Se e' solo nell'Allegato 1:
        applicabile_importanti = TRUE, applicabile_essenziali = FALSE
    - Se e' solo nell'Allegato 2 (raro, ma possibile):
        applicabile_importanti = FALSE, applicabile_essenziali = TRUE

    Per i controlli usiamo quelli dell'Allegato 1 come base;
    i controlli aggiuntivi dell'Allegato 2 vengono aggiunti solo
    se il requirement e' esclusivo dell'Allegato 2.
    """

    # Unisci requirements
    tutti_req = {}
    for codice, req in requirements_imp.items():
        tutti_req[codice] = req.copy()
        # Marca se presente anche nell'Allegato 2
        if codice in requirements_ess:
            tutti_req[codice]["applicabile_essenziali"] = True

    for codice, req in requirements_ess.items():
        if codice not in tutti_req:
            # Solo nell'Allegato 2
            tutti_req[codice] = req.copy()
            tutti_req[codice]["applicabile_importanti"] = False
            tutti_req[codice]["applicabile_essenziali"] = True

    # li ordino come nel documento ACN: prima GOVERN, poi IDENTIFY ecc
    ordine_funzioni = ["GV", "ID", "PR", "DE", "RS", "RC"]
    req_ordinati = sorted(
        tutti_req.values(),
        key=lambda r: (
            ordine_funzioni.index(r["codice"][:2])
            if r["codice"][:2] in ordine_funzioni else 99,
            r["codice"]
        )
    )

    # Unisci controlli: usa quelli dell'Allegato 1 per i req comuni;
    # per i req solo in Allegato 2, usa i controlli dell'Allegato 2.
    codici_solo_ess = {
        c for c in requirements_ess if c not in requirements_imp
    }
    controlli_uniti = list(controlli_imp)
    for ctrl in controlli_ess:
        if ctrl["codice_req"] in codici_solo_ess:
            controlli_uniti.append(ctrl)

    # Costruisci il testo SQL
    righe = []
    righe.append("-- ============================================================")
    righe.append("-- NIS2 Asset DB - Catalogo requirements e controlli ACN")
    righe.append("-- Generato automaticamente da: scripts/genera_seed_acn.py")
    righe.append("--")
    righe.append("-- Fonte dati:")
    righe.append("--   Allegato 1: Misure di sicurezza per i soggetti importanti")
    righe.append("--   Allegato 2: Misure di sicurezza per i soggetti essenziali")
    righe.append("-- Determinazione ACN 379907/2025")
    righe.append("-- https://www.acn.gov.it/portale/nis/modalita-specifiche-base")
    righe.append("-- ============================================================")
    righe.append("")
    righe.append("")

    # INSERT requirements
    righe.append("-- ------------------------------------------------------------")
    righe.append("-- Requirements")
    righe.append("-- ------------------------------------------------------------")
    righe.append("")

    for req in req_ordinati:
        imp = "TRUE" if req["applicabile_importanti"] else "FALSE"
        ess = "TRUE" if req["applicabile_essenziali"] else "FALSE"
        desc = escape_sql(req["descrizione"])
        righe.append(
            f"INSERT INTO requirement "
            f"(codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)"
        )
        righe.append(
            f"VALUES ('{req['codice']}', '{req['categoria']}', '{desc}', {imp}, {ess})"
        )
        righe.append(
            f"ON CONFLICT (codice) DO NOTHING;"
        )
        righe.append("")

    # INSERT controlli
    righe.append("")
    righe.append("-- ------------------------------------------------------------")
    righe.append("-- Controlli")
    righe.append("-- ------------------------------------------------------------")
    righe.append("")

    for ctrl in controlli_uniti:
        testo = escape_sql(ctrl["testo"])
        righe.append("INSERT INTO controllo (id_requirement, numero, testo)")
        righe.append(
            f"VALUES ("
            f"(SELECT id_requirement FROM requirement WHERE codice = '{ctrl['codice_req']}'), "
            f"{ctrl['numero']}, "
            f"'{testo}')"
        )
        righe.append("ON CONFLICT (id_requirement, numero) DO NOTHING;")
        righe.append("")

    # INSERT controllo_status (stato iniziale = non_implementato per tutti)
    righe.append("")
    righe.append("-- ------------------------------------------------------------")
    righe.append("-- Stato iniziale di ogni controllo (non_implementato)")
    righe.append("-- ============================================================")
    righe.append("")
    righe.append("INSERT INTO controllo_status (id_controllo, status, note)")
    righe.append("SELECT id_controllo, 'non_implementato', NULL")
    righe.append("FROM controllo")
    righe.append("ON CONFLICT (id_controllo) DO NOTHING;")
    righe.append("")

    return "\n".join(righe)


def main():
    print("Lettura Allegato 1 (soggetti importanti)...")
    req_imp, ctrl_imp = leggi_xlsx(XLSX_IMP, True, False)
    print(f"  Requirements: {len(req_imp)}, Controlli: {len(ctrl_imp)}")

    print("Lettura Allegato 2 (soggetti essenziali)...")
    req_ess, ctrl_ess = leggi_xlsx(XLSX_ESS, False, True)
    print(f"  Requirements: {len(req_ess)}, Controlli: {len(ctrl_ess)}")

    print("Generazione SQL...")
    sql = genera_sql(req_imp, ctrl_imp, req_ess, ctrl_ess)

    # creo la cartella database/ se non esiste già
    os.makedirs(os.path.dirname(OUTPUT_SQL), exist_ok=True)
    with open(OUTPUT_SQL, "w", encoding="utf-8") as f:
        f.write(sql)

    # Statistiche finali
    n_req    = sql.count("INSERT INTO requirement")
    n_ctrl   = sql.count("INSERT INTO controllo (")
    print(f"\nFile scritto: {OUTPUT_SQL}")
    print(f"  Requirements inseriti: {n_req}")
    print(f"  Controlli inseriti:    {n_ctrl}")


if __name__ == "__main__":
    main()
