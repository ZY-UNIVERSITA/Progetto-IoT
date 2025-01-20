# IoT Monitor: Sistema di Monitoraggio per Temperatura e Umidità

## Descrizione del Progetto

Questo progetto implementa un sistema IoT per il monitoraggio continuo di temperatura e umidità in una stanza. Il sistema utilizza:

- 2 **sensori DHT22** collegati a una **scheda ESP32**.
- 4 **LED**, utilizzati come allarme per segnalare il superamento dei limiti di temperatura o umidità.
- **Schermo SSD1306**, per visualizzare i dati dei sensori in tempo reale.
- **Protocollo MQTT**, per la comunicazione con un broker esterno (**HiveMQ**).
- **Interfaccia Web**, per monitorare i dati in tempo reale, configurare le soglie di allerta e visualizzare lo storico.

Il sistema segnala automaticamente eventuali superamenti dei limiti configurati e consente la gestione dei dati tramite una piattaforma web.

## Funzionalità Principali

- _Monitoraggio in tempo reale_ dei dati provenienti dai sensori.
- _Visualizzazione su schermo_ dei valori di temperatura e umidità.
- _Storico dati_, con rappresentazione grafica per analizzare l’andamento nel tempo.
- _Configurazione delle soglie di allerta_ per temperatura e umidità.
- _Segnalazione visiva con LED_, in caso di valori fuori soglia.
- _Scalabilità_, con possibilità di aggiungere nuovi sensori.
- _Interfaccia Web intuitiva_, per una gestione semplice e veloce.

## Configurazione

Per installare le **dipendenze** per il server, eseguire il comando nella directory 'Backend':
```node
npm run install
```
Per **avviare il server**, eseguire:
```node
npm run dev
```
Per richiedere **l'interfaccia Web**, visitare il sito all'URL:
```node
localhost:3000
```