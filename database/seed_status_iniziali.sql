-- seed_status_iniziali.sql
-- Aggiornamenti allo stato dei controlli ACN per Prima Industrie.
-- Tutti i controlli partono come 'non_implementato' (dal seed_acn.sql),
-- qui aggiorno solo quelli che hanno già una situazione diversa

-- Controlli gia' implementati

UPDATE controllo_status
SET status = 'implementato',
    note   = 'Inventario asset gestito tramite CMDB aziendale (Asset Tiger). Aggiornato mensilmente dall''IT Manager.'
WHERE id_controllo = (
    SELECT c.id_controllo FROM controllo c
    JOIN requirement r ON c.id_requirement = r.id_requirement
    WHERE r.codice = 'ID.AM-01' AND c.numero = 1
);

UPDATE controllo_status
SET status = 'implementato',
    note   = 'Registro software aggiornato trimestralmente dall''IT Manager su foglio condiviso SharePoint.'
WHERE id_controllo = (
    SELECT c.id_controllo FROM controllo c
    JOIN requirement r ON c.id_requirement = r.id_requirement
    WHERE r.codice = 'ID.AM-02' AND c.numero = 1
);

UPDATE controllo_status
SET status = 'implementato',
    note   = 'Inventario fornitori mantenuto nell''ERP SAP con scheda fornitore per referente e tipologia. Aggiornato annualmente.'
WHERE id_controllo = (
    SELECT c.id_controllo FROM controllo c
    JOIN requirement r ON c.id_requirement = r.id_requirement
    WHERE r.codice = 'GV.SC-04' AND c.numero = 1
);

UPDATE controllo_status
SET status = 'implementato',
    note   = 'Firewall Fortinet FortiGate 600E configurato e gestito dal Network Administrator. Policy riviste semestralmente.'
WHERE id_controllo = (
    SELECT c.id_controllo FROM controllo c
    JOIN requirement r ON c.id_requirement = r.id_requirement
    WHERE r.codice = 'PR.IR-01' AND c.numero = 3
);

UPDATE controllo_status
SET status = 'implementato',
    note   = 'Antivirus Sophos Intercept X installato su tutti i client e server Windows. Aggiornamento automatico quotidiano.'
WHERE id_controllo = (
    SELECT c.id_controllo FROM controllo c
    JOIN requirement r ON c.id_requirement = r.id_requirement
    WHERE r.codice = 'DE.CM-09' AND c.numero = 1
);

UPDATE controllo_status
SET status = 'implementato',
    note   = 'Backup giornaliero su NAS locale (NAS-BCK-01) e nastro offline settimanale. Procedure documentate nel piano di continuita''.'
WHERE id_controllo = (
    SELECT c.id_controllo FROM controllo c
    JOIN requirement r ON c.id_requirement = r.id_requirement
    WHERE r.codice = 'PR.DS-11' AND c.numero = 1
);

-- Controlli in fase di implementazione

UPDATE controllo_status
SET status = 'in_implementazione',
    note   = 'Piano di gestione rischi in fase di redazione con il supporto di un consulente esterno. Completamento previsto Q3 2025.'
WHERE id_controllo = (
    SELECT c.id_controllo FROM controllo c
    JOIN requirement r ON c.id_requirement = r.id_requirement
    WHERE r.codice = 'GV.RM-03' AND c.numero = 1
);

UPDATE controllo_status
SET status = 'in_implementazione',
    note   = 'Nomina punto di contatto ACN in corso. Pratica inoltrata all''ufficio legale, attesa risposta ACN entro 30 giorni.'
WHERE id_controllo = (
    SELECT c.id_controllo FROM controllo c
    JOIN requirement r ON c.id_requirement = r.id_requirement
    WHERE r.codice = 'GV.RR-02' AND c.numero = 3
);

UPDATE controllo_status
SET status = 'in_implementazione',
    note   = 'Progetto MFA avviato per gli accessi VPN. Rollout in corso su tutti gli utenti IT, completamento previsto fine anno.'
WHERE id_controllo = (
    SELECT c.id_controllo FROM controllo c
    JOIN requirement r ON c.id_requirement = r.id_requirement
    WHERE r.codice = 'PR.AA-03' AND c.numero = 2
);

-- Controlli non applicabili

UPDATE controllo_status
SET status = 'non_applicabile',
    note   = 'Prima Industrie non sviluppa software internamente. Il controllo non e'' applicabile al contesto aziendale.'
WHERE id_controllo = (
    SELECT c.id_controllo FROM controllo c
    JOIN requirement r ON c.id_requirement = r.id_requirement
    WHERE r.codice = 'PR.PS-06' AND c.numero = 1
);
