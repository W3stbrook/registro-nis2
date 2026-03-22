-- seed_referenti_acn.sql
-- I tre referenti ACN obbligatori (art. 7 D.Lgs. 138/2024)
-- Prima Industrie S.p.A. - dati di esempio

INSERT INTO referente_acn (nome, cognome, email, telefono, ruolo)
VALUES
    ('Giulia', 'Marini',   'giulia.marini@primaindustrie.com',  '+39 011 4512302', 'punto_di_contatto'),
    ('Marco',  'Ferretti', 'marco.ferretti@primaindustrie.com', '+39 011 4512301', 'sostituto_punto_di_contatto'),
    ('Andrea', 'Colombo',  'andrea.colombo@primaindustrie.com', '+39 011 4512303', 'referente_csirt')
ON CONFLICT (ruolo) DO NOTHING;
