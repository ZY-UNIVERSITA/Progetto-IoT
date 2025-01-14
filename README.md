# IoT Monitor: Sistema di Monitoraggio per Temperatura e Umidità

## Descrizione del Progetto
Questo progetto realizza un sistema IoT per il monitoraggio continuo di temperatura e umidità in una stanza utilizzando:

- Due **sensori DHT22** collegati a una scheda **ESP32**.
- Comunicazione tramite il protocollo **MQTT** verso un broker MQTT esterno (**HiveMQ**).
- **Interfaccia Web** per visualizzare i dati in tempo reale, configurare i valori di soglia, e visualizzare uno storico dei dati.

Il sistema notifica eventuali superamenti dei limiti configurati e permette la gestione dei dati attraverso una piattaforma web.

## Funzionalità Principali
- Visualizzazione in tempo reale dei dati rilevati.
- Storico dati per analizzare l'andamento nel tempo.
- Configurazione soglie di allerta per temperatura e umidità.
- Notifiche istantanee in caso di superamento delle soglie.
- Scalabilità per aggiungere nuovi sensori.

## Configurazione
Per installare le dipendenze per il server, eseguire il comando nella directory 'Backend':
```node
npm run install
```
Per eseguire il server, usare il comando:
```node
npm run dev
```
Per richiedere l'interfaccia Web, visitare il sito all'URL:
```node
localhost:3000
```