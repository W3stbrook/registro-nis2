-- seed_servizi.sql
-- Servizi di business Prima Industrie S.p.A. e relazioni con gli asset

INSERT INTO servizio (nome, descrizione)
VALUES
    (
        'Produzione sistemi laser',
        'Progettazione, produzione e vendita di sistemi laser industriali ad alta potenza. Servizio core di Prima Industrie, classificato come rilevante per il settore manifatturiero ai sensi dell''Allegato II della Direttiva NIS2.'
    ),
    (
        'Manutenzione e assistenza tecnica',
        'Servizio di manutenzione preventiva e correttiva dei sistemi laser venduti, con contratti di service a livello globale. Include interventi da remoto tramite accesso VPN supervisionato e interventi on-site.'
    ),
    (
        'Gestione ordini e logistica',
        'Ricezione ordini clienti, pianificazione della produzione, gestione magazzino componenti e spedizione prodotti finiti. Supportato dall''ERP SAP S/4HANA.'
    ),
    (
        'Comunicazioni aziendali',
        'Servizi di posta elettronica, messaggistica istantanea e videoconferenza per tutto il personale. Erogato tramite Microsoft 365 in modalita'' cloud.'
    )
ON CONFLICT (nome) DO NOTHING;


-- Relazioni asset-servizio (idempotenti)
INSERT INTO asset_servizio (id_asset, id_servizio)
SELECT a.id_asset, s.id_servizio
FROM (VALUES
    ('PLC linea laser (PLC-LASER-L01)',     'Produzione sistemi laser'),
    ('PLC linea saldatura (PLC-SALD-L02)',  'Produzione sistemi laser'),
    ('Sistema SCADA produzione',             'Produzione sistemi laser'),
    ('Server ERP SAP S/4HANA',              'Produzione sistemi laser'),
    ('Domain Controller primario (DC01)',    'Produzione sistemi laser'),
    ('VPN Gateway (VPN-GW)',                 'Manutenzione e assistenza tecnica'),
    ('Portale Microsoft 365',               'Manutenzione e assistenza tecnica'),
    ('Firewall perimetrale (FW-PERIMETRO)', 'Manutenzione e assistenza tecnica'),
    ('Server ERP SAP S/4HANA',              'Gestione ordini e logistica'),
    ('File server aziendale (FS01)',         'Gestione ordini e logistica'),
    ('Domain Controller primario (DC01)',    'Gestione ordini e logistica'),
    ('Portale Microsoft 365',               'Comunicazioni aziendali'),
    ('Smartphone aziendale CISO',           'Comunicazioni aziendali'),
    ('Firewall perimetrale (FW-PERIMETRO)', 'Comunicazioni aziendali')
) AS v(nome_asset, nome_servizio)
JOIN asset    a ON a.nome = v.nome_asset
JOIN servizio s ON s.nome = v.nome_servizio
ON CONFLICT (id_asset, id_servizio) DO NOTHING;
