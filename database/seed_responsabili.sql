-- seed_responsabili.sql
-- Responsabili interni Prima Industrie S.p.A. (dati di esempio)

INSERT INTO responsabile (nome, cognome, email, ruolo, telefono)
VALUES
    ('Marco',   'Ferretti',  'marco.ferretti@primaindustrie.com',   'IT Manager',            '+39 011 4512301'),
    ('Giulia',  'Marini',    'giulia.marini@primaindustrie.com',    'CISO',                  '+39 011 4512302'),
    ('Andrea',  'Colombo',   'andrea.colombo@primaindustrie.com',   'System Administrator',  '+39 011 4512303'),
    ('Roberta', 'Esposito',  'roberta.esposito@primaindustrie.com', 'Network Administrator', '+39 011 4512304'),
    ('Luca',    'Ricci',     'luca.ricci@primaindustrie.com',       'OT/ICS Specialist',     '+39 011 4512305')
ON CONFLICT (email) DO NOTHING;
