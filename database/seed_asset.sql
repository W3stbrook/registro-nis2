-- seed_asset.sql
-- Inventario asset Prima Industrie S.p.A. (dati di esempio)
-- Requisiti ID.AM-01 e ID.AM-02 della Determinazione ACN

INSERT INTO asset (nome, tipo, sistema_operativo, descrizione, criticita, id_responsabile)
VALUES
    (
        'Domain Controller primario (DC01)',
        'dispositivo_it',
        'Windows Server 2022',
        'Controller di dominio Active Directory primario. Gestisce autenticazione e autorizzazione di tutti gli utenti e computer della rete aziendale. Ospitato nel datacenter di Collegno (TO).',
        'alto',
        (SELECT id_responsabile FROM responsabile WHERE email = 'andrea.colombo@primaindustrie.com')
    ),
    (
        'Domain Controller secondario (DC02)',
        'dispositivo_it',
        'Windows Server 2022',
        'Controller di dominio Active Directory di riserva. Replica automatica da DC01. Collocato nel rack secondario per garantire la ridondanza del servizio di autenticazione.',
        'alto',
        (SELECT id_responsabile FROM responsabile WHERE email = 'andrea.colombo@primaindustrie.com')
    ),
    (
        'File server aziendale (FS01)',
        'dispositivo_it',
        'Windows Server 2019',
        'Server di archiviazione per documenti aziendali, disegni tecnici e reportistica. Cartelle condivise organizzate per reparto. Backup giornaliero su NAS e nastro settimanale.',
        'alto',
        (SELECT id_responsabile FROM responsabile WHERE email = 'andrea.colombo@primaindustrie.com')
    ),
    (
        'Server ERP SAP S/4HANA',
        'applicazione',
        'SUSE Linux Enterprise Server 15',
        'Sistema ERP SAP S/4HANA che gestisce i processi aziendali principali: acquisti, produzione, contabilita'', logistica e gestione magazzino. Accesso tramite SAP GUI e portale web Fiori.',
        'alto',
        (SELECT id_responsabile FROM responsabile WHERE email = 'marco.ferretti@primaindustrie.com')
    ),
    (
        'Firewall perimetrale (FW-PERIMETRO)',
        'rete',
        NULL,
        'Firewall Fortinet FortiGate 600E che protegge il perimetro della rete aziendale. Gestisce le policy di accesso dalla rete Internet e dalla DMZ verso la rete interna. Aggiornamento signature settimanale.',
        'alto',
        (SELECT id_responsabile FROM responsabile WHERE email = 'roberta.esposito@primaindustrie.com')
    ),
    (
        'Switch core (SW-CORE-01)',
        'rete',
        NULL,
        'Switch core Cisco Catalyst 9500 che interconnette tutti i segmenti di rete aziendale (LAN IT, VLAN OT, DMZ, VLAN management). Configurato con ridondanza HSRP.',
        'alto',
        (SELECT id_responsabile FROM responsabile WHERE email = 'roberta.esposito@primaindustrie.com')
    ),
    (
        'PLC linea laser (PLC-LASER-L01)',
        'dispositivo_ot',
        NULL,
        'Controllore logico programmabile Siemens SIMATIC S7-1500 che governa la linea di taglio laser CO2 nel reparto produzione di Collegno. Comunicazione via PROFINET con il sistema SCADA.',
        'alto',
        (SELECT id_responsabile FROM responsabile WHERE email = 'luca.ricci@primaindustrie.com')
    ),
    (
        'PLC linea saldatura (PLC-SALD-L02)',
        'dispositivo_ot',
        NULL,
        'Controllore logico programmabile Siemens SIMATIC S7-300 che governa il robot di saldatura ABB IRB 6700 nella linea L02. Sistema in produzione dal 2018, supporto esteso fino al 2028.',
        'medio',
        (SELECT id_responsabile FROM responsabile WHERE email = 'luca.ricci@primaindustrie.com')
    ),
    (
        'Sistema SCADA produzione',
        'applicazione',
        'Windows 10 IoT Enterprise',
        'Sistema SCADA Wonderware InTouch per la supervisione e il controllo dei processi produttivi. Interfaccia operatori per il monitoraggio delle linee laser, saldatura e assemblaggio. Rete OT segregata dalla rete IT tramite DMZ industriale.',
        'alto',
        (SELECT id_responsabile FROM responsabile WHERE email = 'luca.ricci@primaindustrie.com')
    ),
    (
        'VPN Gateway (VPN-GW)',
        'rete',
        NULL,
        'Concentratore VPN Fortinet FortiGate 200E per accesso remoto sicuro del personale IT e dei fornitori autorizzati. Autenticazione con certificati e OTP. Accesso limitato ai segmenti di rete necessari.',
        'alto',
        (SELECT id_responsabile FROM responsabile WHERE email = 'roberta.esposito@primaindustrie.com')
    ),
    (
        'Smartphone aziendale CISO',
        'dispositivo_mobile',
        'iOS 17',
        'iPhone 14 assegnato alla CISO per le comunicazioni di emergenza e la gestione degli incidenti fuori sede. Configurato con MDM Jamf. Accesso alle mail aziendali tramite Microsoft 365.',
        'medio',
        (SELECT id_responsabile FROM responsabile WHERE email = 'giulia.marini@primaindustrie.com')
    ),
    (
        'Telecamere IP reparto produzione',
        'dispositivo_iot',
        NULL,
        'Sistema di 24 telecamere IP Axis Q3538 nel reparto produzione per la sorveglianza fisica. Connesse alla VLAN dedicata videosorveglianza, isolata dalla rete IT. Registrazione su NVR locale con retention 30 giorni.',
        'basso',
        (SELECT id_responsabile FROM responsabile WHERE email = 'roberta.esposito@primaindustrie.com')
    ),
    (
        'NAS backup (NAS-BCK-01)',
        'dispositivo_it',
        'TrueNAS Core 13',
        'Storage NAS QNAP TS-1886XU-RP destinato ai backup giornalieri di file server, database e configurazioni di rete. Replica notturna verso il sito secondario di Torino. Capacita'' utile 96 TB.',
        'alto',
        (SELECT id_responsabile FROM responsabile WHERE email = 'andrea.colombo@primaindustrie.com')
    ),
    (
        'Portale Microsoft 365',
        'applicazione',
        NULL,
        'Suite Microsoft 365 Business Premium in cloud per posta elettronica (Exchange Online), collaborazione (Teams, SharePoint) e produttivita'' (Office). Tenant dedicato a Prima Industrie con tenant ID verificato.',
        'medio',
        (SELECT id_responsabile FROM responsabile WHERE email = 'marco.ferretti@primaindustrie.com')
    )
ON CONFLICT (nome) DO NOTHING;
