# Registro NIS2

Applicazione web per gestire il registro degli asset, servizi e fornitori in ottica di conformità alla direttiva NIS2.

Project work per il corso di Informatica per le Aziende Digitali (L-31), Università Telematica Pegaso.

Demo online: https://registro-nis2.onrender.com

## Struttura del progetto

```
registro-nis2/
├── database/
│   ├── schema.sql
│   ├── seed_acn.sql             (generato da genera_seed_acn.py)
│   ├── seed_profilo.sql
│   ├── seed_responsabili.sql
│   ├── seed_referenti_acn.sql
│   ├── seed_asset.sql
│   ├── seed_servizi.sql
│   ├── seed_fornitori.sql
│   ├── seed_status_iniziali.sql
│   └── queries.sql
├── scripts/
│   └── genera_seed_acn.py
├── backend/
│   ├── app.py
│   └── esporta_csv.py
├── frontend/
│   ├── base.html
│   ├── index.html
│   ├── asset_lista.html
│   ├── asset_dettaglio.html
│   ├── asset_form.html
│   ├── fornitori_lista.html
│   ├── fornitore_form.html
│   ├── responsabili_lista.html
│   ├── responsabile_form.html
│   ├── referenti_acn.html
│   ├── referente_acn_form.html
│   ├── acn_lista.html
│   └── profilo_azienda.html
├── requirements.txt
├── render.yaml
└── README.md
```

## Cosa serve

PostgreSQL 14+, Python 3.10+ e pip. Il frontend è tutto Bootstrap 5.3 via CDN quindi non serve installare nulla lato client.

Per le dipendenze Python:

```bash
pip install -r requirements.txt
```

Le librerie usate sono Flask (web framework), psycopg2-binary (driver PostgreSQL) e openpyxl (per leggere gli xlsx ACN). Nessuna di queste fa parte della libreria standard.

## Seed ACN

I controlli di sicurezza nel database vengono dai file Excel ufficiali dell'ACN, non li ho scritti a mano. I file si scaricano dal portale ACN:

- [Allegato 1 - soggetti importanti](https://www.acn.gov.it/portale/documents/d/guest/modalita-e-specifiche-di-base-nis-soggetti-importanti)
- [Allegato 2 - soggetti essenziali](https://www.acn.gov.it/portale/documents/d/guest/modalita-e-specifiche-di-base-nis-soggetti-essenziali)

Vanno salvati come `allegato1_importanti.xlsx` e `allegato2_essenziali.xlsx` nella root del progetto, poi:

```bash
cd scripts
python genera_seed_acn.py
```

Questo genera `database/seed_acn.sql` con tutti gli INSERT per requirements, controlli e stati.

## Setup database locale

Creare il database e caricare tutto in ordine (le foreign key richiedono un ordine preciso):

```bash
psql -U postgres -c "CREATE DATABASE nis2_pw_schembri;"
psql -U postgres -d nis2_pw_schembri -f database/schema.sql
psql -U postgres -d nis2_pw_schembri -f database/seed_acn.sql
psql -U postgres -d nis2_pw_schembri -f database/seed_profilo.sql
psql -U postgres -d nis2_pw_schembri -f database/seed_responsabili.sql
psql -U postgres -d nis2_pw_schembri -f database/seed_referenti_acn.sql
psql -U postgres -d nis2_pw_schembri -f database/seed_asset.sql
psql -U postgres -d nis2_pw_schembri -f database/seed_servizi.sql
psql -U postgres -d nis2_pw_schembri -f database/seed_fornitori.sql
psql -U postgres -d nis2_pw_schembri -f database/seed_status_iniziali.sql
```

Per verificare che sia tutto ok si possono lanciare le query di test:

```bash
psql -U postgres -d nis2_pw_schembri -f database/queries.sql
```

## Avvio

```bash
cd backend
python app.py
```

Apre su `http://127.0.0.1:5000`. I parametri di connessione al database sono in `DB_CONFIG` dentro `app.py`.

## Deploy su Render

Il progetto gira su Render con Flask + PostgreSQL sullo stesso piano free.

Per il setup: creare un database PostgreSQL su Render, poi caricare schema e seed usando la External Database URL che si trova nella dashboard:

```bash
psql "postgresql://user:pass@host/registro_nis2" -f database/schema.sql
psql "postgresql://user:pass@host/registro_nis2" -f database/seed_acn.sql
psql "postgresql://user:pass@host/registro_nis2" -f database/seed_profilo.sql
psql "postgresql://user:pass@host/registro_nis2" -f database/seed_responsabili.sql
psql "postgresql://user:pass@host/registro_nis2" -f database/seed_referenti_acn.sql
psql "postgresql://user:pass@host/registro_nis2" -f database/seed_asset.sql
psql "postgresql://user:pass@host/registro_nis2" -f database/seed_servizi.sql
psql "postgresql://user:pass@host/registro_nis2" -f database/seed_fornitori.sql
psql "postgresql://user:pass@host/registro_nis2" -f database/seed_status_iniziali.sql
```

Poi creare un Web Service collegato al repo GitHub con build command `pip install -r requirements.txt` e start command `gunicorn backend.app:app`. Come variabile d'ambiente serve `DATABASE_URL` con la Internal Database URL.

L'app controlla se `DATABASE_URL` è impostata: se sì si collega al db di Render, altrimenti usa i parametri locali.

## Esportazione CSV

Per esportare il profilo di conformità ACN in formato CSV (utile per eventuale caricamento sul portale):

```bash
cd backend
python esporta_csv.py                                    # solo requisiti importanti
python esporta_csv.py --tutti                             # importanti + essenziali
python esporta_csv.py --output profilo_prima_industrie.csv  # nome file custom
```

Il CSV usa separatore `;` e codifica UTF-8 con BOM, così Excel lo apre senza problemi.
