-- seed_fornitori.sql
-- Fornitori Prima Industrie S.p.A. e relazioni con gli asset
-- Requisito GV.SC-04 della Determinazione ACN

INSERT INTO fornitore (ragione_sociale, referente_nome, referente_email, tipo_fornitura, livello_accesso, impatto_interruzione)
VALUES
    (
        'Microsoft Corporation',
        'Account Team Microsoft Italia',
        'account-primaindustrie@microsoft.com',
        'Software cloud (Microsoft 365, Azure AD)',
        'limitato',
        'medio'
    ),
    (
        'SAP Italia S.r.l.',
        'Matteo Bianchi',
        'm.bianchi@sap.com',
        'Licenze e supporto ERP SAP S/4HANA',
        'limitato',
        'alto'
    ),
    (
        'Siemens S.p.A. - Digital Industries',
        'Carlo Negri',
        'carlo.negri@siemens.com',
        'Supporto PLC e automazione industriale (SIMATIC S7)',
        'limitato',
        'alto'
    ),
    (
        'Fortinet Italia',
        'Supporto Tecnico Enterprise',
        'support-ent@fortinet.it',
        'Firewall e sicurezza perimetrale (FortiGate)',
        'completo',
        'alto'
    ),
    (
        'TIM S.p.A.',
        'Account Manager TIM Business',
        'business.primaindustrie@tim.it',
        'Connettivita'' Internet (fibra dedicata 1 Gbps) e linea MPLS',
        'nessuno',
        'alto'
    ),
    (
        'Sophos Ltd.',
        'Supporto Tecnico Sophos',
        'support@sophos.com',
        'Antivirus e EDR (Intercept X)',
        'limitato',
        'medio'
    ),
    (
        'QNAP Systems Inc.',
        'Supporto QNAP EMEA',
        'support-emea@qnap.com',
        'Storage NAS e manutenzione hardware backup',
        'nessuno',
        'medio'
    )
ON CONFLICT (ragione_sociale) DO NOTHING;


-- Relazioni asset-fornitore
INSERT INTO asset_fornitore (id_asset, id_fornitore)
SELECT a.id_asset, f.id_fornitore
FROM (VALUES
    ('Portale Microsoft 365',               'Microsoft Corporation'),
    ('Domain Controller primario (DC01)',    'Microsoft Corporation'),
    ('Server ERP SAP S/4HANA',              'SAP Italia S.r.l.'),
    ('PLC linea laser (PLC-LASER-L01)',      'Siemens S.p.A. - Digital Industries'),
    ('PLC linea saldatura (PLC-SALD-L02)',   'Siemens S.p.A. - Digital Industries'),
    ('Firewall perimetrale (FW-PERIMETRO)',  'Fortinet Italia'),
    ('VPN Gateway (VPN-GW)',                 'Fortinet Italia'),
    ('Firewall perimetrale (FW-PERIMETRO)',  'TIM S.p.A.'),
    ('Domain Controller primario (DC01)',    'Sophos Ltd.'),
    ('File server aziendale (FS01)',         'Sophos Ltd.'),
    ('NAS backup (NAS-BCK-01)',              'QNAP Systems Inc.')
) AS v(nome_asset, nome_fornitore)
JOIN asset    a ON a.nome            = v.nome_asset
JOIN fornitore f ON f.ragione_sociale = v.nome_fornitore
ON CONFLICT (id_asset, id_fornitore) DO NOTHING;
