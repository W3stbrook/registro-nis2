-- ============================================================
-- NIS2 Asset DB - Catalogo requirements e controlli ACN
-- Generato automaticamente da: scripts/genera_seed_acn.py
--
-- Fonte dati:
--   Allegato 1: Misure di sicurezza per i soggetti importanti
--   Allegato 2: Misure di sicurezza per i soggetti essenziali
-- Determinazione ACN 379907/2025
-- https://www.acn.gov.it/portale/nis/modalita-specifiche-base
-- ============================================================


-- ------------------------------------------------------------
-- Requirements
-- ------------------------------------------------------------

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('GV.OC-04', 'GOVERN', 'Gli obiettivi, le capacità e i servizi critici dai quali gli stakeholder dipendono o che si aspettano dall''organizzazione sono compresi e comunicati.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('GV.PO-01', 'GOVERN', 'La politica per la gestione del rischio di cybersecurity è stabilita in base al contesto organizzativo, alla strategia di cybersecurity e alle priorità, ed è comunicata e applicata.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('GV.PO-02', 'GOVERN', 'La politica per la gestione del rischio di cybersecurity è revisionata, aggiornata, comunicata e applicata per riflettere i cambiamenti nei requisiti, nelle minacce, nella tecnologia e nella missione dell''organizzazione.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('GV.RM-03', 'GOVERN', 'Le attività e gli esiti della gestione del rischio di cybersecurity sono parte integrante dei processi di gestione del rischio dell''organizzazione.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('GV.RR-02', 'GOVERN', 'I ruoli, le responsabilità e le autorità relative alla gestione del rischio di cybersecurity sono stabiliti, comunicati, compresi e applicati.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('GV.RR-04', 'GOVERN', 'La cybersecurity è inclusa nelle pratiche delle risorse umane.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('GV.SC-01', 'GOVERN', 'Sono stabiliti e accettati dagli stakeholder dell''organizzazione un programma, una strategia, obiettivi, politiche e processi di gestione del rischio di cybersecurity della catena di approvvigionamento.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('GV.SC-02', 'GOVERN', 'I ruoli e le responsabilità in materia di cybersecurity per fornitori, clienti e partner sono stabiliti, comunicati e coordinati internamente ed esternamente.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('GV.SC-04', 'GOVERN', 'I fornitori sono noti e prioritizzati in base alla criticità.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('GV.SC-05', 'GOVERN', 'I requisiti per affrontare i rischi di cybersecurity nella catena di approvvigionamento sono stabiliti, prioritizzati e integrati nei contratti e in altri tipi di accordi con i fornitori e altre terze parti rilevanti.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('GV.SC-07', 'GOVERN', 'I rischi posti da un fornitore, dai suoi prodotti e servizi e da altre terze parti sono compresi, registrati, prioritizzati, valutati, trattati e monitorati nel corso della relazione.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('ID.AM-01', 'IDENTIFY', 'Sono mantenuti gli inventari dell''hardware gestito dall''organizzazione.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('ID.AM-02', 'IDENTIFY', 'Sono mantenuti gli inventari del software, dei servizi e dei sistemi gestiti dall''organizzazione.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('ID.AM-03', 'IDENTIFY', 'Sono mantenute le rappresentazioni delle comunicazioni di rete, dei flussi di dati di rete interni ed esterni, autorizzati dall''organizzazione.', FALSE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('ID.AM-04', 'IDENTIFY', 'Sono mantenuti gli inventari dei servizi erogati dai fornitori.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('ID.IM-01', 'IDENTIFY', 'Sono identificati miglioramenti in esito alle valutazioni.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('ID.IM-04', 'IDENTIFY', 'I piani di risposta agli incidenti e gli altri piani di cybersecurity che impattano le operazioni sono stabiliti, comunicati, mantenuti e migliorati.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('ID.RA-01', 'IDENTIFY', 'Le vulnerabilità negli asset sono identificate, confermate e registrate.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('ID.RA-05', 'IDENTIFY', 'Minacce, vulnerabilità, probabilità e impatti sono utilizzati per comprendere il rischio inerente e per informare la prioritizzazione della risposta al rischio.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('ID.RA-06', 'IDENTIFY', 'Le risposte al rischio sono scelte, prioritizzate, pianificate, monitorate e comunicate.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('ID.RA-08', 'IDENTIFY', 'Sono stabiliti processi per la ricezione, l''analisi e la risposta alle divulgazioni di vulnerabilità.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('PR.AA-01', 'PROTECT', 'Le identità e le credenziali degli utenti, dei servizi e dell''hardware autorizzati sono gestite dall''organizzazione.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('PR.AA-03', 'PROTECT', 'Utenti, servizi e hardware sono autenticati', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('PR.AA-05', 'PROTECT', 'I permessi, i diritti e le autorizzazioni di accesso sono definiti in una politica, gestiti, applicati e rivisti e incorporano i principi del minimo privilegio e della separazione dei compiti.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('PR.AA-06', 'PROTECT', 'L''accesso fisico agli asset è gestito, monitorato e applicato in misura appropriata al rischio.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('PR.AT-01', 'PROTECT', 'Il personale è sensibilizzato e formato in modo da possedere le conoscenze e le competenze per svolgere compiti di carattere generale tenendo conto dei rischi di cybersecurity.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('PR.AT-02', 'PROTECT', 'Gli individui che ricoprono ruoli specializzati sono sensibilizzati e formati in modo da possedere le conoscenze e le competenze per svolgere i pertinenti compiti tenendo conto dei rischi di cybersecurity.', FALSE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('PR.DS-01', 'PROTECT', 'La riservatezza, l''integrità e la disponibilità dei dati a riposo (data-at-rest) sono protette.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('PR.DS-02', 'PROTECT', 'La riservatezza, l''integrità e la disponibilità dei dati in transito (data-in-transit) sono protette.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('PR.DS-11', 'PROTECT', 'I backup dei dati sono creati, protetti, mantenuti e verificati.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('PR.IR-01', 'PROTECT', 'Le reti e gli ambienti sono protetti dall''accesso logico e dall''uso non autorizzati.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('PR.IR-03', 'PROTECT', 'Sono implementati meccanismi per soddisfare i requisiti di resilienza in situazioni normali e avverse.', FALSE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('PR.PS-01', 'PROTECT', 'Sono stabilite e applicate pratiche di gestione della configurazione', FALSE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('PR.PS-02', 'PROTECT', 'Il software è mantenuto, sostituito e rimosso in base al rischio.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('PR.PS-03', 'PROTECT', 'L''hardware è mantenuto, sostituito e rimosso in base al rischio.', FALSE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('PR.PS-04', 'PROTECT', 'I registri di log sono generati e resi disponibili per il monitoraggio continuo.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('PR.PS-06', 'PROTECT', 'Le pratiche di sviluppo sicuro del software sono integrate e le loro prestazioni sono monitorate durante l''intero ciclo di vita del software.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('DE.CM-01', 'DETECT', 'Le reti e i servizi di rete sono monitorati per individuare eventi potenzialmente avversi.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('DE.CM-09', 'DETECT', 'L''hardware e il software di elaborazione, gli ambienti di runtime e i loro dati sono monitorati per individuare eventi potenzialmente avversi.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('RS.CO-02', 'RESPOND', 'Gli stakeholder interni ed esterni sono informati degli incidenti.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('RS.MA-01', 'RESPOND', 'Il piano di risposta agli incidenti è eseguito in coordinamento con le terze parti interessate una volta dichiarato un incidente.', TRUE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('RC.CO-03', 'RECOVER', 'Le attività di ripristino e i progressi nel ripristino delle capacità operative sono comunicati agli stakeholder interni ed esterni designati.', FALSE, TRUE);

INSERT INTO requirement (codice, categoria, descrizione, applicabile_importanti, applicabile_essenziali)
VALUES ('RC.RP-01', 'RECOVER', 'La parte del piano di risposta agli incidenti relativa al rispristino viene eseguita una volta avviata dal processo di risposta agli incidenti.', TRUE, TRUE);


-- ------------------------------------------------------------
-- Controlli
-- ------------------------------------------------------------

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.OC-04'), 1, 'È mantenuto un elenco aggiornato dei sistemi informativi e di rete rilevanti.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.RM-03'), 1, 'Nell''ambito dei processi di gestione del rischio del soggetto NIS e nel rispetto delle politiche di cui alla misura GV.PO-01, è definito, attuato, aggiornato e documentato un piano di gestione dei rischi per la sicurezza informatica per identificare, analizzare, valutare, trattare e monitorare i rischi.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.RR-02'), 1, 'È definita, approvata dagli organi di amministrazione e direttivi, e resa nota alle articolazioni competenti del soggetto NIS, l''organizzazione per la sicurezza informatica e ne sono stabiliti ruoli e responsabilità.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.RR-02'), 2, 'È mantenuto un elenco aggiornato del personale dell''organizzazione di cui al punto 1 avente specifici ruoli e responsabilità ed è reso noto alle articolazioni competenti del soggetto   NIS.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.RR-02'), 3, 'All’interno dell’organizzazione per la sicurezza informatica di cui al punto 1, sono inclusi il punto di contatto e il suo sostituto, il referente CSIRT e gli eventuali suoi sostituti, di cui alla determinazione adottata ai sensi dell’articolo 7, comma 6 del decreto NIS.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.RR-02'), 4, 'I ruoli e le responsabilità di cui al punto 1 sono riesaminati e, se opportuno, aggiornati periodicamente e comunque almeno ogni due anni, nonché qualora si verifichino incidenti significativi, variazioni organizzative o mutamenti dell’esposizione alle minacce e ai relativi rischi.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.RR-04'), 1, 'Per almeno i sistemi informativi e di rete rilevanti, il personale autorizzato ad accedervi è individuato previa valutazione dell’esperienza, capacità e affidabilità e deve fornire idonea garanzia del pieno rispetto della normativa in materia di sicurezza informatica.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.RR-04'), 2, 'Gli amministratori di sistema dei sistemi informativi e di rete sono individuati previa valutazione dell’esperienza, capacità e affidabilità e devono fornire idonea garanzia del pieno rispetto della normativa in materia di sicurezza informatica.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.RR-04'), 3, 'Nel rispetto delle politiche di cui alla misura GV.PO-01, sono adottate e documentate le procedure in relazione ai punti 1 e 2.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.PO-01'), 1, 'Sono adottate e documentate politiche di sicurezza informatica per almeno i seguenti ambiti:
a) gestione del rischio;
b) ruoli e responsabilità;
c) affidabilità delle risorse umane;
d) conformità e audit di sicurezza;
e) gestione dei rischi per la sicurezza informatica della catena di approvvigionamento;
f) gestione degli asset;
g) gestione delle vulnerabilità;
h) continuità operativa, ripristino in caso di disastro e gestione delle crisi informatiche;
i) gestione dell''autenticazione, delle identità digitali e del controllo accessi;
j) sicurezza fisica;
k) formazione del personale e consapevolezza;
l) sicurezza dei dati;
m) sviluppo, configurazione, manutenzione e dismissione dei sistemi informativi e di rete;
n) protezione delle reti e delle comunicazioni;
o) monitoraggio degli eventi di sicurezza;
p) risposta agli incidenti e ripristino.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.PO-01'), 2, 'Per gli ambiti di cui al punto 1 sono incluse almeno le politiche in relazione ai requisiti indicati nella tabella 1 in Appendice al presente allegato.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.PO-01'), 3, 'Le politiche di cui al punto 1 sono approvate dagli organi di amministrazione e direttivi e rese note alle articolazioni competenti del soggetto NIS tenuto anche conto della necessità di conoscere (need to know).');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.PO-02'), 1, 'Le politiche di cui alla misura GV.PO-01 sono riesaminate e, se opportuno, aggiornate periodicamente e comunque almeno con cadenza annuale, nonché qualora si verifichino evoluzioni del contesto normativo in materia di sicurezza informatica, incidenti significativi, variazioni organizzative o mutamenti dell’esposizione alle minacce e ai relativi rischi.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.PO-02'), 2, 'Ai fini del riesame di cui al punto 1, è verificata almeno la conformità delle politiche di cui alla misura GV.PO-01 alla normativa in materia di sicurezza informatica.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.SC-01'), 1, 'In merito all’affidamento di forniture con potenziali impatti sulla sicurezza dei sistemi informativi e di rete, anche mediante ricorso agli strumenti delle centrali di committenza di cui all’allegato I.1, articolo 1, comma 1, lettera i), del decreto legislativo 31 marzo 2023, n. 36, sono previsti:
a)	il coinvolgimento dell’organizzazione per la sicurezza informatica di cui alla misura GV.RR-02 nella definizione ed esecuzione dei processi di approvvigionamento a partire dalla fase di identificazione e progettazione della fornitura;
b)	in accordo agli esiti della valutazione del rischio associato alla fornitura di cui alla misura GV.SC-07, la definizione di requisiti di sicurezza sulla fornitura coerenti con le misure di sicurezza applicate dal soggetto NIS ai sistemi informativi e di rete.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.SC-02'), 1, 'Nell''ambito dell''organizzazione per la sicurezza informatica di cui alla misura GV.RR-02, sono definiti e resi noti alle articolazioni competenti del soggetto NIS gli eventuali ruoli e responsabilità in materia di sicurezza informatica assegnati al personale delle terze parti.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.SC-02'), 2, 'Il personale di cui al punto 1 avente specifici ruoli e responsabilità è incluso nell’elenco di cui al punto 2 della misura GV.RR-02.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.SC-04'), 1, 'È mantenuto un inventario aggiornato dei fornitori delle forniture con potenziali impatti sulla sicurezza dei sistemi informativi e di rete, che comprende almeno:
a)	gli estremi di contatto del referente della fornitura;
b)	la tipologia di fornitura.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.SC-05'), 1, 'Fatte salve motivate e documentate ragioni normative o tecniche, i requisiti di sicurezza di cui alla misura GV.SC-01, punto 1, lettera b) sono inseriti nelle richieste di offerta, bandi di gara, contratti, accordi e convenzioni relativi alle forniture con potenziali impatti sulla sicurezza dei sistemi informativi e di rete.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.SC-07'), 1, 'Nell’ambito della valutazione del rischio di cui alla misura ID.RA-05, è valutato e documentato il rischio associato alle forniture. A tal fine, sono valutati almeno:
a) il livello di accesso del fornitore ai sistemi informativi e di rete del soggetto NIS;
b) l''accesso del fornitore alla proprietà intellettuale e ai dati anche sulla base della loro criticità;
c) l''impatto di una grave interruzione della fornitura;
d) i tempi e i costi di ripristino in caso di indisponibilità dei servizi;
e) i ruoli e le responsabilità del fornitore nel governo dei sistemi informativi e di rete.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'GV.SC-07'), 2, 'È verificata periodicamente e documentata la conformità delle forniture ai requisiti di cui alla misura GV.SC-05.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.AM-01'), 1, 'È mantenuto un inventario aggiornato degli apparati fisici (hardware) che compongono i sistemi informativi e di rete, ivi inclusi i dispositivi IT, IoT, OT e mobili, approvati da attori interni al soggetto NIS.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.AM-02'), 1, 'È mantenuto un inventario aggiornato dei servizi, dei sistemi e delle applicazioni software che compongono i sistemi informativi e di rete, ivi incluse le applicazioni commerciali, open-source e custom, anche accessibili tramite API, approvati da attori interni al soggetto NIS.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.AM-04'), 1, 'È mantenuto un inventario aggiornato dei servizi informatici erogati dai fornitori, ivi inclusi i servizi cloud.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.RA-01'), 1, 'Le informazioni di cui al punto 1 della misura ID.RA-08 sono utilizzate per identificare eventuali vulnerabilità sui i sistemi informativi e di rete.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.RA-05'), 1, 'In accordo al piano di gestione dei rischi per la sicurezza informatica di cui alla misura GV.RM-03, è eseguita e documentata la valutazione del rischio posto alla sicurezza dei sistemi informativi e di rete, anche con riferimento alle eventuali dipendenze da fornitori e partner terzi, che comprende almeno:
a) l’identificazione del rischio;
b) l’analisi del rischio;
c) la ponderazione del rischio.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.RA-05'), 2, 'La valutazione del rischio di cui al punto 1 è eseguita a intervalli pianificati e comunque almeno ogni due anni, nonché qualora si verifichino incidenti significativi, variazioni organizzative o mutamenti dell’esposizione alle minacce e ai relativi rischi.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.RA-05'), 3, 'La valutazione del rischio cui al punto 1 è approvata dagli organi di amministrazione e direttivi.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.RA-06'), 1, 'È definito, documentato, eseguito e monitorato un piano di trattamento dei rischi per la sicurezza informatica che comprende almeno:
a) le opzioni di trattamento e le misure da attuare in merito al trattamento di ciascun rischio individuato e le relative priorità;
b) le articolazioni competenti per l''attuazione delle misure di trattamento dei rischi e le tempistiche per tale attuazione;
c) la descrizione e le ragioni che giustificano l''accettazione di eventuali rischi residui al trattamento.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.RA-06'), 2, 'Qualora per motivate e documentate ragioni normative o tecniche non siano attuati i requisiti di cui alla tabella 2 in appendice al presente allegato, sono adottate, ove applicabile, misure di mitigazione compensative e il piano di cui al punto 1 include la descrizione di tali misure e dell’eventuale rischio residuo.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.RA-06'), 3, 'Il piano di cui al punto 1, ivi compresa l’accettazione di eventuali rischi residui, è approvato dagli organi di amministrazione e direttivi.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.RA-08'), 1, 'Sono monitorati almeno i canali di comunicazione del CSIRT Italia, nonché di eventuali CERT e Information Sharing & Analysis Centre (ISAC) settoriali, al fine di acquisire, analizzare e rispondere alle informazioni sulle vulnerabilità.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.RA-08'), 2, 'Le vulnerabilità, ivi comprese quelle identificate ai sensi della misura ID.RA-01 , sono prontamente risolte attraverso aggiornamenti di sicurezza o misure di mitigazione, ove disponibili, ovvero accettando e documentando il rischio in accordo al piano di trattamento dei rischi di cui alla misura ID.RA-06  .');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.RA-08'), 3, 'È definito, attuato, aggiornato e documentato un piano di gestione delle vulnerabilità che comprende almeno:
a) le modalità per l''identificazione delle vulnerabilità di cui alla misura ID.RA-01 e la relativa pianificazione delle attività;
b) le modalità per monitorare, ricevere, analizzare e rispondere alle informazioni sulle vulnerabilità;
c) le procedure, i ruoli, le responsabilità per lo svolgimento delle attività di cui alle lettere a) e b).');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.RA-08'), 4, 'Il piano di cui al punto 3 è approvato dagli organi di amministrazione e direttivi.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.IM-01'), 1, 'In accordo agli esiti del riesame di cui al punto 1 della misura GV.PO-02, è definito, attuato, documentato e approvato dagli organi di amministrazioni e direttivi un piano di adeguamento che identifichi gli interventi necessari ad assicurare l’attuazione delle politiche di sicurezza.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.IM-01'), 2, 'Gli organi di amministrazione e direttivi sono informati mediante apposite relazioni periodiche sugli esiti dei piani di cui al punto 1.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.IM-04'), 1, 'Per almeno i sistemi informativi e di rete rilevanti è definito, attuato, aggiornato e documentato un piano di continuità operativa, che comprende almeno:
a) le finalità, ivi incluse le esigenze di continuità operativa, e l''ambito di applicazione;
b) i ruoli e le responsabilità;
c) i contatti principali e i canali di comunicazione (interni ed esterni);
d) le condizioni per l''attivazione e la disattivazione del piano;
e) le risorse necessarie, ivi compresi i backup e le ridondanze.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.IM-04'), 2, 'Per almeno i sistemi informativi e di rete rilevanti è definito, attuato, aggiornato e documentato un piano di ripristino in caso di disastro, che comprende almeno:
a) le finalità, ivi incluse le esigenze di ripristino in caso di disastro, e l''ambito di applicazione;
b) i ruoli e le responsabilità;
c) i contatti principali e i canali di comunicazione (interni ed esterni);
d) le condizioni per l''attivazione e la disattivazione del piano;
e) le risorse necessarie, ivi compresi i backup e le ridondanze; 
f) l''ordine di ripristino delle operazioni;
g) le procedure di ripristino per operazioni specifiche, compresi gli obiettivi di ripristino.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.IM-04'), 3, 'Per almeno i sistemi informativi e di rete rilevanti è definito, attuato, aggiornato e documentato un piano per la gestione delle crisi informatiche che comprende almeno:
a) i ruoli e le responsabilità del personale e, se opportuno, dei fornitori, specificando l''assegnazione dei ruoli in situazioni di crisi, comprese le procedure specifiche da seguire;
b) le modalità di comunicazione tra i soggetti e le autorità competenti.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.IM-04'), 4, 'I piani di cui ai punti 1, 2 e 3 sono approvati dagli organi di amministrazione e direttivi.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.IM-04'), 5, 'I piani di cui ai punti 1, 2 e 3 sono riesaminati e, se opportuno, aggiornati periodicamente e comunque almeno ogni due anni, nonché qualora si verifichino incidenti significativi o mutamenti dell’esposizione alle minacce e ai relativi rischi.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AA-01'), 1, 'Tutte le utenze, ivi incluse quelle con privilegi amministrativi e quelle utilizzate per l’accesso remoto, sono censite, approvate da attori interni al soggetto NIS e, fatte salve motivate e documentate ragioni tecniche, in accordo agli esiti della valutazione del rischio di cui alla misura ID.RA-05, sono individuali per gli utenti.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AA-01'), 2, 'Le credenziali (ad esempio nome utente e password) relative alle utenze sono robuste e aggiornate in accordo agli esiti della valutazione del rischio di cui alla misura ID.RA-05.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AA-01'), 3, 'Per almeno i sistemi informativi e di rete rilevanti, sono verificate periodicamente le utenze e le relative autorizzazioni, aggiornandole/revocandole in caso di variazioni (ad esempio trasferimento o cessazione di personale).');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AA-01'), 4, 'Nel rispetto delle politiche di cui alla misura GV.PO-01, sono adottate e documentate le procedure in relazione ai punti 1, 2 e 3.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AA-03'), 1, 'Le modalità di autenticazione delle utenze per accedere ai sistemi informativi e di rete sono commisurate al rischio. A tal fine sono valutati almeno i rischi connessi: 
a)	ai privilegi delle utenze;
b)	alla criticità dei sistemi informativi e di rete;
c)	alla tipologia di operazioni che le utenze possono effettuare sui sistemi informativi e di rete.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AA-03'), 2, 'Per almeno i sistemi informativi e di rete rilevanti, in accordo agli esiti della valutazione del rischio di cui alla misura ID.RA-05, sono impiegate soluzioni di autenticazione multifattore.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AA-03'), 3, 'Nel rispetto delle politiche di cui alla misura GV.PO-01, sono adottate e documentate le procedure in relazione ai punti 1 e 2.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AA-05'), 1, 'I permessi sono assegnati alle utenze in accordo ai principi del minimo privilegio e della separazione delle funzioni, tenuto anche conto della necessità di conoscere (need to know).');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AA-05'), 2, 'È assicurata la completa distinzione tra utenze con e senza privilegi amministrativi degli amministratori di sistema alle quali debbono corrispondere credenziali diverse.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AA-05'), 3, 'Nel rispetto delle politiche di cui alla misura GV.PO-01, sono adottate e documentate le procedure in relazione ai punti 1 e 2.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AA-06'), 1, 'Per almeno i sistemi informativi e di rete rilevanti, l’accesso fisico è protetto.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AA-06'), 2, 'Nel rispetto delle politiche di cui alla misura GV.PO-01, sono adottate e documentate le procedure in relazione al punto 1.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AT-01'), 1, 'È definito, attuato, aggiornato e documentato un piano di formazione in materia di sicurezza informatica del personale, ivi inclusi gli organi di amministrazione e direttivi, che comprende almeno:
a)	la pianificazione delle attività di formazione previste con l’indicazione dei contenuti della formazione fornita;
b)	le eventuali modalità di verifica dell''acquisizione dei contenuti.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AT-01'), 2, 'Il piano di formazione di cui al punto 1 è approvato dagli organi di amministrazione e direttivi.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AT-01'), 3, 'È mantenuto un registro aggiornato recante l''elenco dei dipendenti che hanno ricevuto la formazione di cui al punto 1, i relativi contenuti e l''elenco delle verifiche svolte laddove previste.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.DS-01'), 1, 'Per almeno i sistemi informativi e di rete rilevanti, in accordo agli esiti della valutazione del rischio di cui alla misura ID.RA-05, fatte salve motivate e documentate ragioni normative o tecniche, i dati memorizzati sui dispositivi portatili, ivi inclusi laptop, smartphone e tablet, e sui supporti removibili, sono cifrati con protocolli e algoritmi allo stato dell’arte e considerati sicuri.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.DS-01'), 2, 'Fatte salve motivate e documentate ragioni normative o tecniche, è disabilitata l''auto esecuzione dei supporti rimovibili ed è effettuata la loro scansione al fine di rilevare codici malevoli prima che siano utilizzati nei sistemi informativi e di rete.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.DS-01'), 3, 'Nel rispetto delle politiche di cui alla misura GV.PO-01, sono adottate e documentate le procedure in relazione ai punti 1 e 2.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.DS-02'), 1, 'Per almeno i sistemi informativi e di rete rilevanti, ivi inclusi quelli di comunicazione vocale, video e testuale, in accordo agli esiti della valutazione del rischio di cui alla misura ID.RA-05, fatte salve motivate e documentate ragioni normative o tecniche, sono utilizzati, per la trasmissione dei dati da e verso l’esterno del soggetto NIS, protocolli e algoritmi di cifratura allo stato dell’arte e considerati sicuri.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.DS-02'), 2, 'Nel rispetto delle politiche di cui alla misura GV.PO-01, sono adottate e documentate le procedure in relazione al punto 1.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.DS-11'), 1, 'In accordo alle esigenze di continuità operativa e di ripristino in caso di disastro individuate nei piani di cui alla misura ID.IM-04, sono effettuati periodicamente i backup dei dati e delle configurazioni e, per almeno i sistemi informativi e di rete rilevanti, sono anche conservate copie di backup offline.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.DS-11'), 2, 'Nel rispetto delle politiche di cui alla misura GV.PO-01, sono adottate e documentate le procedure in relazione al punto 1.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.PS-02'), 1, 'Fatte salve motivate e documentate ragioni normative o tecniche, in accordo agli esiti della valutazione del rischio di cui alla misura ID.RA-05, è installato esclusivamente software, ivi compresi i sistemi operativi, per il quale è garantita la disponibilità di aggiornamenti di sicurezza.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.PS-02'), 2, 'Fatte salve motivate e documentate ragioni normative o tecniche, sono installati, senza ingiustificato ritardo, gli ultimi aggiornamenti di sicurezza rilasciati dal produttore in coerenza con il piano di gestione delle vulnerabilità di cui alla misura ID.RA-08.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.PS-02'), 3, 'Nel rispetto delle politiche di cui alla misura GV.PO-01, sono adottate e documentate le procedure in relazione ai punti 1e 2.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.PS-04'), 1, 'Tutti gli accessi eseguiti da remoto e quelli effettuati con utenze con privilegi amministrativi sono registrati.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.PS-04'), 2, 'Per almeno i sistemi informativi e di rete rilevanti, sono acquisiti e, in modo sicuro e possibilmente centralizzato, conservati almeno i log necessari ai fini del monitoraggio degli eventi di sicurezza, ivi compresi quelli relativi agli accessi di cui al punto 1.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.PS-04'), 3, 'In accordo agli esiti della valutazione rischio di cui alla misura ID.RA-05, sono definite e documentate le tempistiche di conservazione dei log di cui al punto 2.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.PS-04'), 4, 'Nel rispetto delle politiche di cui alla misura GV.PO-01, sono adottate e documentate le procedure in relazione ai punti 1 e 2.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.PS-06'), 1, 'Sono adottate e documentate pratiche di sviluppo sicuro del codice nello sviluppo del software.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.IR-01'), 1, 'Per almeno i sistemi informativi e di rete rilevanti, sono definite e documentate le eventuali attività consentite da remoto e implementate adeguate misure di sicurezza per l’accesso.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.IR-01'), 2, 'È mantenuto un elenco aggiornato dei sistemi informativi e di rete ai quali è possibile accedere da remoto con la descrizione delle relative modalità di accesso.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.IR-01'), 3, 'Sono presenti, aggiornati, mantenuti e configurati in modo adeguato sistemi perimetrali, quali firewall.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.IR-01'), 4, 'Nel rispetto delle politiche di cui alla misura GV.PO-01, sono adottate e documentate le procedure in relazione ai punti 2 e 3.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'DE.CM-01'), 1, 'Per almeno i sistemi informativi e di rete rilevanti, sono presenti, aggiornati, mantenuti e configurati in modo adeguato strumenti tecnici per rilevare tempestivamente gli incidenti significativi.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'DE.CM-01'), 2, 'Sono definiti e documentati i livelli di servizio attesi (SL) dei servizi e delle attività del soggetto NIS anche ai fini di rilevare tempestivamente gli incidenti significativi.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'DE.CM-01'), 3, 'Nel rispetto delle politiche di cui alla misura GV.PO-01, sono adottate e documentate le procedure in relazione al punto 1.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'DE.CM-09'), 1, 'Fatte salve motivate e documentate ragioni normative o tecniche, sono presenti, aggiornati, mantenuti e configurati in modo adeguato, sistemi di protezione dei punti terminali (endpoint) per il rilevamento del codice malevolo.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'DE.CM-09'), 2, 'Nel rispetto delle politiche di cui alla misura GV.PO-01, sono adottate e documentate le procedure in relazione al punto 1.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'RS.MA-01'), 1, 'È definito, attuato, aggiornato e documentato un piano per la gestione degli incidenti di sicurezza informatica e la notifica al CSIRT Italia, in accordo a quanto previsto dall’articolo 25 del decreto NIS, che comprende almeno:
a)	le fasi e le procedure di gestione e notifica degli incidenti con l’indicazione dei relativi ruoli e delle responsabilità;
b)	le procedure per la predisposizione e la trasmissione delle relazioni di cui all’articolo 25, comma 5, lettere c), d) ed e) del decreto NIS;
c)	le informazioni di contatto per la segnalazione degli incidenti;
d)	le modalità di comunicazione interna, anche con riguardo al coinvolgimento degli organi di amministrazione e direttivi, ed esterna;
e)	la reportistica da utilizzare per la documentazione dell’incidente.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'RS.MA-01'), 2, 'Il piano di cui al punto 1 è approvato dagli organi di amministrazione e direttivi.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'RS.MA-01'), 3, 'Il piano di cui al punto 1 è riesaminato e, se opportuno, aggiornato periodicamente e comunque almeno ogni due anni, nonché qualora si verifichino incidenti significativi, integrando le relative lezioni apprese, o mutamenti dell’esposizione alle minacce e ai relativi rischi.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'RS.CO-02'), 1, 'In accordo al piano per la gestione degli incidenti di cui alla misura RS.MA-01, sono documentate e adottate procedure per comunicare senza ingiustificato ritardo, se ritenuto opportuno e qualora possibile, sentito il CSIRT Italia, ovvero qualora intimato dall’Agenzia per la cybersicurezza nazionale ai sensi dell’articolo 37, comma 3, lettere g) e h), del decreto NIS:
a)	ai destinatari dei propri servizi, gli incidenti significativi che possono ripercuotersi negativamente sulla fornitura di tali servizi;
b)	ai destinatari dei propri servizi che sono potenzialmente interessati da una minaccia informatica significativa, le misure o azioni correttive o di mitigazione che tali destinatari possono adottare in risposta a tale minaccia e la natura di tale minaccia.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'RS.CO-02'), 2, 'Sono documentate e adottate procedure per informare il pubblico sugli incidenti occorsi, qualora intimato dall’Agenzia per la cybersicurezza nazionale ai sensi dell’art. 37, comma 3, lettera i) del decreto NIS.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'RC.RP-01'), 1, 'Nell''ambito del piano per la gestione degli incidenti di cui alla misura RS.MA-01, sono adottate e documentate procedure per il ripristino  con riguardo almeno al ripristino del normale funzionamento dei sistemi informativi e di rete coinvolti da incidenti di sicurezza informatica, ivi compresi quelli di cui all’articolo 25 del decreto NIS.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'ID.AM-03'), 1, 'È mantenuto un inventario aggiornato dei flussi di rete tra i sistemi informativi e di rete del soggetto NIS e l’esterno, approvati da attori interni al soggetto NIS.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AT-02'), 1, 'Il piano di cui alla misura PR.AT-01 prevede una formazione dedicata al personale con ruoli specializzati, ossia che richiedono una serie di capacità e competenze attinenti alla sicurezza, ivi compresi gli amministratori di sistema, che comprende almeno:
a)	le istruzioni relative alla configurazione e al funzionamento sicuri dei sistemi informativi e di rete;
b)	le informazioni sulle minacce informatiche note;
c)	le istruzioni sul comportamento da tenere in caso di eventi rilevanti per la sicurezza.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.AT-02'), 2, 'È mantenuto un registro aggiornato recante l''elenco dei dipendenti che hanno ricevuto la formazione di cui al punto 1, i relativi contenuti e l''elenco delle verifiche svolte laddove previste.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.PS-01'), 1, 'Per almeno i sistemi informativi e di rete rilevanti, sono definite, e documentate in un elenco aggiornato, le loro configurazioni di riferimento sicure (hardened).');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.PS-01'), 2, 'Nel rispetto delle politiche di cui alla misura GV.PO-01, sono adottate e documentate le procedure in relazione al punto 1.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.PS-03'), 1, 'Per almeno i sistemi informativi e di rete rilevanti, sono adottate e documentate procedure per il trasferimento fisico e la dismissione di dispositivi atti alla memorizzazione di dati in modo sicuro.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.PS-03'), 2, 'Per almeno i sistemi informativi e di rete rilevanti, sono mantenuti uno o più registri delle manutenzioni effettuate sull''hardware.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.IR-03'), 1, 'In accordo agli esiti della valutazione del rischio di cui alla misura ID.RA-05, sono utilizzati sistemi di comunicazione di emergenza protetti    .');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'PR.IR-03'), 2, 'Nel rispetto delle politiche di cui alla misura GV.PO-01, sono adottate e documentate le procedure in relazione al punto 1.');

INSERT INTO controllo (id_requirement, numero, testo)
VALUES ((SELECT id_requirement FROM requirement WHERE codice = 'RC.CO-03'), 1, 'Sono adottate e documentate procedure per comunicare alle parti interne interessate, ivi incluse le articolazioni competenti del soggetto NIS, le attività di ripristino a seguito di un incidente.');


-- ------------------------------------------------------------
-- Stato iniziale di ogni controllo (non_implementato)
-- ============================================================

INSERT INTO controllo_status (id_controllo, status, note)
SELECT id_controllo, 'non_implementato', NULL
FROM controllo;
