#!/usr/bin/env python3
# esporta_csv.py - legge la vista profilo_acn_csv e genera un CSV
# pronto per Excel (separatore ; e BOM UTF-8)
#
# uso:
#   python esporta_csv.py                    -> solo soggetti importanti
#   python esporta_csv.py --tutti            -> importanti + essenziali
#   python esporta_csv.py --output file.csv  -> nome file personalizzato

import csv
import sys
import argparse
import psycopg2
import psycopg2.extras
from datetime import datetime

# stessi parametri di app.py, db locale
DB_CONFIG = {
    "host":     "localhost",
    "port":     5432,
    "dbname":   "nis2_pw_schembri",
    "user":     "postgres",
    "password": "postgres"
}


def esporta(output_file, solo_importanti=True):
    """Interroga la vista e scrive il CSV nel file indicato."""
    try:
        conn = psycopg2.connect(**DB_CONFIG)
    except psycopg2.OperationalError as e:
        print(f"Errore connessione db: {e}")
        sys.exit(1)

    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    if solo_importanti:
        cur.execute("""
            SELECT
                categoria,
                codice_requirement,
                descrizione_requirement,
                numero_controllo,
                testo_controllo,
                status_implementazione,
                note,
                data_aggiornamento
            FROM profilo_acn_csv
            WHERE applicabile_importanti = TRUE
            ORDER BY categoria, codice_requirement, numero_controllo
        """)
    else:
        cur.execute("""
            SELECT
                categoria,
                codice_requirement,
                descrizione_requirement,
                numero_controllo,
                testo_controllo,
                status_implementazione,
                note,
                data_aggiornamento
            FROM profilo_acn_csv
            ORDER BY categoria, codice_requirement, numero_controllo
        """)

    righe = cur.fetchall()
    cur.close()
    conn.close()

    # Intestazioni del CSV in italiano per leggibilita'
    intestazioni = [
        "Categoria",
        "Codice requisito",
        "Descrizione requisito",
        "N. controllo",
        "Testo controllo",
        "Stato implementazione",
        "Note",
        "Data aggiornamento"
    ]

    # utf-8-sig aggiunge il BOM all'inizio del file, altrimenti
    # Excel non capisce che è UTF-8 e mostra i caratteri accentati sbagliati
    with open(output_file, "w", newline="", encoding="utf-8-sig") as f:
        # punto e virgola come separatore perché in Italia la virgola è il decimale
        writer = csv.writer(f, delimiter=";", quoting=csv.QUOTE_ALL)
        writer.writerow(intestazioni)

        for riga in righe:
            writer.writerow([
                riga["categoria"],
                riga["codice_requirement"],
                riga["descrizione_requirement"],
                riga["numero_controllo"],
                riga["testo_controllo"],
                riga["status_implementazione"],
                riga["note"] or "",
                riga["data_aggiornamento"].strftime("%d/%m/%Y %H:%M")
            ])

    print(f"CSV esportato: {output_file}")
    print(f"Righe scritte: {len(righe)}")


def main():
    parser = argparse.ArgumentParser(
        description="Esporta il profilo ACN in formato CSV."
    )
    parser.add_argument(
        "--tutti",
        action="store_true",
        help="Includi anche i requisiti solo per soggetti essenziali."
    )
    parser.add_argument(
        "--output",
        default=None,
        help="Nome del file CSV di output (default: profilo_acn_YYYYMMDD.csv)."
    )
    args = parser.parse_args()

    if args.output:
        nome_file = args.output
    else:
        data_oggi = datetime.now().strftime("%Y%m%d")
        nome_file = f"profilo_acn_{data_oggi}.csv"

    esporta(nome_file, solo_importanti=not args.tutti)


if __name__ == "__main__":
    main()
