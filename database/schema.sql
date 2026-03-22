-- schema.sql
-- Luca Schembri - Informatica per le Aziende Digitali (L-31)
-- Schema del registro asset per la conformità NIS2 di Prima Industrie S.p.A.


-- Tipi ENUM: valori ammessi per i campi che accettano solo opzioni fisse

-- i tipi possibili per gli asset, corrispondono alle categorie
-- che si trovano nei registri di asset management NIS2
CREATE TYPE tipo_asset AS ENUM (
    'dispositivo_it',
    'dispositivo_iot',
    'dispositivo_ot',
    'dispositivo_mobile',
    'applicazione',
    'rete'
);

CREATE TYPE livello_criticita AS ENUM (
    'alto',
    'medio',
    'basso'
);

CREATE TYPE livello_accesso AS ENUM (
    'nessuno',
    'limitato',
    'completo'
);

-- i tre ruoli previsti dall'art. 7 D.Lgs. 138/2024
CREATE TYPE ruolo_referente AS ENUM (
    'punto_di_contatto',
    'sostituto_punto_di_contatto',
    'referente_csirt'
);

CREATE TYPE stato_controllo AS ENUM (
    'non_applicabile',
    'non_implementato',
    'in_implementazione',
    'implementato'
);

-- le 6 funzioni del framework NIST CSF 2.0 che ACN ha ripreso
-- nella determinazione 164179/2025
CREATE TYPE categoria_requirement AS ENUM (
    'GOVERN',
    'IDENTIFY',
    'PROTECT',
    'DETECT',
    'RESPOND',
    'RECOVER'
);


-- Profilo azienda: tabella singola con i dati dell'organizzazione.
-- Serve per determinare se è soggetto "importante" o "essenziale"
-- (art. 3 D.Lgs. 138/2024). Il CHECK su id_profilo = 1 garantisce
-- che ci sia un solo record (pattern singleton).

CREATE TABLE profilo_azienda (
    -- DEFAULT 1 + CHECK: così il record è sempre uno solo
    id_profilo          INTEGER      PRIMARY KEY DEFAULT 1 CHECK (id_profilo = 1),
    ragione_sociale     VARCHAR(200) NOT NULL,
    settore             VARCHAR(100) NOT NULL,
    sotto_settore       VARCHAR(200),
    fatturato_milioni   NUMERIC(10,2),
    num_dipendenti      INTEGER,
    infrastruttura_critica BOOLEAN   NOT NULL DEFAULT FALSE,
    -- qui il valore viene calcolato lato applicazione (Flask)
    classificazione     VARCHAR(20)  NOT NULL DEFAULT 'importante'
                        CHECK (classificazione IN ('importante', 'essenziale')),
    data_aggiornamento  TIMESTAMP    NOT NULL DEFAULT NOW()
);


-- Catalogo ACN: tabelle con i requisiti e i controlli ufficiali
-- della Determinazione ACN 164179/2025

-- Requisiti ACN (es. GV.RM-03, ID.AM-01) con il flag che indica
-- se si applica ai soggetti importanti, essenziali, o entrambi
CREATE TABLE requirement (
    id_requirement      SERIAL PRIMARY KEY,
    codice              VARCHAR(20)  NOT NULL UNIQUE,
    categoria           categoria_requirement NOT NULL,
    descrizione         TEXT         NOT NULL,
    applicabile_importanti  BOOLEAN  NOT NULL DEFAULT FALSE,
    applicabile_essenziali  BOOLEAN  NOT NULL DEFAULT FALSE
);

-- Ogni requirement ha uno o più controlli numerati (punto 1, punto 2, ecc.)
CREATE TABLE controllo (
    id_controllo        SERIAL PRIMARY KEY,
    id_requirement      INTEGER      NOT NULL REFERENCES requirement(id_requirement),
    numero              INTEGER      NOT NULL,
    testo               TEXT         NOT NULL,

    -- lo stesso numero non puo' comparire due volte nello stesso requirement
    UNIQUE (id_requirement, numero)
);

-- Stato di implementazione per ogni controllo.
-- data_aggiornamento viene aggiornata dal trigger qui sotto
CREATE TABLE controllo_status (
    id_controllo        INTEGER      PRIMARY KEY
                                     REFERENCES controllo(id_controllo),
    status              stato_controllo NOT NULL DEFAULT 'non_implementato',
    note                TEXT,
    data_aggiornamento  TIMESTAMP    NOT NULL DEFAULT NOW()
);


-- Registro operativo: dati specifici dell'organizzazione

-- Personale interno che ha in carico uno o più asset
CREATE TABLE responsabile (
    id_responsabile     SERIAL PRIMARY KEY,
    nome                VARCHAR(100) NOT NULL,
    cognome             VARCHAR(100) NOT NULL,
    email               VARCHAR(200) NOT NULL UNIQUE,
    ruolo               VARCHAR(100) NOT NULL,
    telefono            VARCHAR(20)
);

-- Inventario degli asset IT/OT/IoT (misura ID.AM-01 ACN)
CREATE TABLE asset (
    id_asset            SERIAL PRIMARY KEY,
    nome                VARCHAR(200) NOT NULL UNIQUE,
    tipo                tipo_asset   NOT NULL,  -- usa l'ENUM definito sopra
    sistema_operativo   VARCHAR(100),            -- può essere NULL per asset di rete
    descrizione         TEXT         NOT NULL,
    criticita           livello_criticita NOT NULL,
    id_responsabile     INTEGER      NOT NULL REFERENCES responsabile(id_responsabile)
);

-- Storico modifiche: il trigger salva qui una copia dell'asset
-- prima di ogni UPDATE, così abbiamo le versioni precedenti
CREATE TABLE asset_version (
    id_version          SERIAL PRIMARY KEY,
    id_asset            INTEGER      NOT NULL REFERENCES asset(id_asset),
    -- lo snapshot è una stringa di testo con i campi chiave=valore
    -- non è un vero JSON perché non serviva quella complessità
    snapshot            TEXT         NOT NULL,
    data_modifica       TIMESTAMP    NOT NULL DEFAULT NOW(),
    motivo_modifica     TEXT
);

-- Servizi erogati dall'organizzazione nel perimetro NIS2
CREATE TABLE servizio (
    id_servizio         SERIAL PRIMARY KEY,
    nome                VARCHAR(200) NOT NULL UNIQUE,
    descrizione         TEXT         NOT NULL
);

-- Relazione N:M tra asset e servizi
CREATE TABLE asset_servizio (
    id_asset            INTEGER      NOT NULL REFERENCES asset(id_asset),
    id_servizio         INTEGER      NOT NULL REFERENCES servizio(id_servizio),
    PRIMARY KEY (id_asset, id_servizio)
);

-- Fornitori terzi che hanno impatto sulla sicurezza (misura GV.SC-04 ACN)
CREATE TABLE fornitore (
    id_fornitore        SERIAL PRIMARY KEY,
    ragione_sociale     VARCHAR(200) NOT NULL UNIQUE,
    referente_nome      VARCHAR(200) NOT NULL,
    referente_email     VARCHAR(200) NOT NULL,
    tipo_fornitura      VARCHAR(100) NOT NULL,
    -- riuso l'ENUM livello_accesso per indicare quanto accede ai nostri sistemi
    livello_accesso     livello_accesso NOT NULL,
    -- riuso livello_criticita per l'impatto se il fornitore si interrompe
    impatto_interruzione livello_criticita NOT NULL
);

-- Relazione N:M tra asset e fornitori
CREATE TABLE asset_fornitore (
    id_asset            INTEGER      NOT NULL REFERENCES asset(id_asset),
    id_fornitore        INTEGER      NOT NULL REFERENCES fornitore(id_fornitore),
    PRIMARY KEY (id_asset, id_fornitore)
);

-- Referenti ACN: punto di contatto, sostituto e referente CSIRT
-- (art. 7 D.Lgs. 138/2024). UNIQUE su ruolo per evitare duplicati
CREATE TABLE referente_acn (
    id_referente        SERIAL PRIMARY KEY,
    nome                VARCHAR(100) NOT NULL,
    cognome             VARCHAR(100) NOT NULL,
    email               VARCHAR(200) NOT NULL,
    telefono            VARCHAR(20)  NOT NULL,
    ruolo               ruolo_referente NOT NULL UNIQUE
);


-- Indici sulle colonne più usate nelle query

CREATE INDEX idx_asset_criticita ON asset(criticita);
CREATE INDEX idx_asset_tipo ON asset(tipo);
CREATE INDEX idx_controllo_requirement ON controllo(id_requirement);
CREATE INDEX idx_controllo_status ON controllo_status(status);
CREATE INDEX idx_asset_version_asset ON asset_version(id_asset);


-- Trigger

-- salva una "fotografia" dell'asset prima che venga modificato
-- così possiamo tenere traccia delle versioni precedenti
CREATE OR REPLACE FUNCTION salva_versione_asset()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO asset_version (id_asset, snapshot, data_modifica)
    VALUES (
        OLD.id_asset,
        -- costruisco una stringa con i valori principali dell'asset
        'id=' || OLD.id_asset ||
        ', nome=' || OLD.nome ||
        ', tipo=' || OLD.tipo::TEXT ||
        ', sistema_operativo=' || COALESCE(OLD.sistema_operativo, 'N/A') ||
        ', descrizione=' || OLD.descrizione ||
        ', criticita=' || OLD.criticita::TEXT ||
        ', id_responsabile=' || OLD.id_responsabile::TEXT,
        NOW()
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_versione_asset
BEFORE UPDATE ON asset
FOR EACH ROW
EXECUTE FUNCTION salva_versione_asset();

-- ogni volta che qualcuno cambia lo stato di un controllo
-- aggiorniamo il timestamp così sappiamo quando è stato toccato l'ultima volta
CREATE OR REPLACE FUNCTION aggiorna_data_status()
RETURNS TRIGGER AS $$
BEGIN
    NEW.data_aggiornamento := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_data_status
BEFORE UPDATE ON controllo_status
FOR EACH ROW
EXECUTE FUNCTION aggiorna_data_status();
