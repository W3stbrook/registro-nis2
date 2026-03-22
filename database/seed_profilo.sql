-- Profilo azienda: Prima Industrie S.p.A.
-- Classificata come soggetto IMPORTANTE ai sensi
-- dell'art. 3, comma 2 del D.Lgs. 138/2024:
--   - settore manifatturiero (Allegato II NIS2)
--   - fatturato > 10 milioni di euro
--   - più di 50 dipendenti
--   - non opera infrastrutture critiche

INSERT INTO profilo_azienda (
    ragione_sociale,
    settore,
    sotto_settore,
    fatturato_milioni,
    num_dipendenti,
    infrastruttura_critica,
    classificazione
) VALUES (
    'Prima Industrie S.p.A.',
    'Fabbricazione',
    'Fabbricazione di macchine e apparecchiature (NACE 28)',
    350.00,
    1200,
    FALSE,
    'importante'
)
ON CONFLICT (id_profilo) DO NOTHING;
