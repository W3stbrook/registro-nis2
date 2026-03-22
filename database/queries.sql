-- queries.sql
-- Luca Schembri - Informatica per le Aziende Digitali (L-31)
-- Query operative per il registro asset + vista per l'esportazione CSV


-- Query 1: Asset critici con il relativo responsabile
-- Elenca tutti gli asset con criticità 'alto' e chi ne è responsabile.
-- Utile per sapere subito chi contattare in caso di incidente

SELECT
    a.id_asset,
    a.nome                  AS asset,
    a.tipo,
    a.sistema_operativo,
    a.criticita,
    r.nome || ' ' || r.cognome AS responsabile,
    r.email                 AS email_responsabile,
    r.ruolo                 AS ruolo_responsabile
FROM asset a
JOIN responsabile r ON a.id_responsabile = r.id_responsabile
WHERE a.criticita = 'alto'
ORDER BY a.tipo, a.nome;


-- Query 2: Servizi erogati e asset che li supportano
-- Per ogni servizio mostra gli asset collegati, con tipo e criticità.
-- Serve per capire quanto è esposto un servizio se un asset viene compromesso

SELECT
    s.nome                  AS servizio,
    a.nome                  AS asset,
    a.tipo                  AS tipo_asset,
    a.criticita             AS criticita_asset,
    r.nome || ' ' || r.cognome AS responsabile_asset
FROM servizio s
JOIN asset_servizio ase ON s.id_servizio = ase.id_servizio
JOIN asset a            ON ase.id_asset = a.id_asset
JOIN responsabile r     ON a.id_responsabile = r.id_responsabile
ORDER BY s.nome, a.criticita DESC, a.nome;


-- Query 3: Dipendenze da terze parti (asset - fornitore)
-- Mappa gli asset con i fornitori che hanno accesso o impatto.
-- I casi più critici (accesso completo, impatto alto) vengono prima

SELECT
    a.nome                  AS asset,
    a.criticita             AS criticita_asset,
    f.ragione_sociale       AS fornitore,
    f.tipo_fornitura,
    f.livello_accesso,
    f.impatto_interruzione,
    f.referente_nome        AS contatto_fornitore,
    f.referente_email       AS email_fornitore
FROM asset a
JOIN asset_fornitore af ON a.id_asset = af.id_asset
JOIN fornitore f        ON af.id_fornitore = f.id_fornitore
ORDER BY
    CASE f.impatto_interruzione WHEN 'alto' THEN 1 WHEN 'medio' THEN 2 ELSE 3 END,
    CASE f.livello_accesso      WHEN 'completo' THEN 1 WHEN 'limitato' THEN 2 ELSE 3 END,
    a.nome;


-- Query 4: Figure chiave per la gestione incidenti
-- Unisce i referenti ACN formali e i responsabili degli asset critici.
-- Serve per avere un quadro rapido di chi coinvolgere per una notifica CSIRT

SELECT
    categoria,
    ruolo,
    nominativo,
    email,
    telefono
FROM (
    SELECT
        'Referente ACN'              AS categoria,
        ra.ruolo::TEXT               AS ruolo,
        ra.nome || ' ' || ra.cognome AS nominativo,
        ra.email,
        ra.telefono
    FROM referente_acn ra

    UNION ALL

    -- responsabili degli asset ad alta criticità
    SELECT
        'Responsabile asset critico'    AS categoria,
        r.ruolo                         AS ruolo,
        r.nome || ' ' || r.cognome      AS nominativo,
        r.email,
        r.telefono
    FROM responsabile r
    WHERE r.id_responsabile IN (
        SELECT DISTINCT id_responsabile FROM asset WHERE criticita = 'alto'
    )
) AS contatti
ORDER BY categoria, ruolo;


-- Vista profilo_acn_csv: una riga per ogni controllo ACN con tutti i campi
-- utili per compilare il profilo di sicurezza richiesto da ACN.
-- Viene esportata in CSV dallo script esporta_csv.py

CREATE OR REPLACE VIEW profilo_acn_csv AS
SELECT
    r.categoria::TEXT           AS categoria,
    r.codice                    AS codice_requirement,
    r.descrizione               AS descrizione_requirement,
    c.numero                    AS numero_controllo,
    c.testo                     AS testo_controllo,
    cs.status::TEXT             AS status_implementazione,
    COALESCE(cs.note, '')       AS note,
    cs.data_aggiornamento       AS data_aggiornamento,
    r.applicabile_importanti,
    r.applicabile_essenziali
FROM requirement r
JOIN controllo c        ON r.id_requirement = c.id_requirement
JOIN controllo_status cs ON c.id_controllo = cs.id_controllo
ORDER BY
    r.categoria,
    r.codice,
    c.numero;


-- query di verifica per controllare che la vista funzioni

-- conta controlli per categoria e status
SELECT
    categoria,
    status_implementazione,
    COUNT(*) AS numero_controlli
FROM profilo_acn_csv
GROUP BY categoria, status_implementazione
ORDER BY categoria, status_implementazione;

-- solo requisiti per soggetti importanti (caso Prima Industrie)
SELECT
    codice_requirement,
    numero_controllo,
    status_implementazione,
    note
FROM profilo_acn_csv
WHERE applicabile_importanti = TRUE
ORDER BY categoria, codice_requirement, numero_controllo;
