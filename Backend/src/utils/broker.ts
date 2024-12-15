import mqtt, { MqttClient } from "mqtt";
import { sendDataToClients } from "./websocket";
import { BrokerConnectionAttempts, SensorData } from "./classes";
import connection from "./db";

// Configurazione del broker MQTT
const BROKER_URL: string = 'mqtt://broker.hivemq.com';
export const TOPIC_NAMES: string[] = [ 'sensori-server', 'server-sensori' ];
const MAX_RETRIES: number = 10;

export let connectionAttempts: BrokerConnectionAttempts;

// Funzione che gestisce la connessione la broker
export const connectToBroker = (): void => {
    connectionAttempts = new BrokerConnectionAttempts();

    connect();
}

// Funzione per la connessione al broker
const connect = (): void => {
    connectionAttempts.incrementConnectionAttempts();

    console.log("Tentativo di connessione numero: " + connectionAttempts.getConnectionAttempts());

    // Mqtt prova a riconnettersi ogni secondi se la connessione non è andata a buon fine
    // reconmectPeriod permette di disabilitare la riconnessione automatica
    connectionAttempts.setClient(mqtt.connect(BROKER_URL, { reconnectPeriod: 0 }));

    // Se la connessione ha avuto successo, si connette al topic
    connectionAttempts.getClient().on('connect', (): void => {
        console.log('Connesso ok al broker MQTT.');
        subscribeToTopic();
    });

    // Gestione degli errori
    connectionAttempts.getClient().on('error', (err: Error): void => {
        console.error('Errore di connessione:', err.message);
        handleConnectionError(connectionAttempts);
    });

    // Gestione della chiusura della connessione
    connectionAttempts.getClient().on('close', (): void => {
        console.log('Connessione con MQTT chiusa.');
    });
};

// Gestione dell'errore, effettua 10 riconnessioni prima di arrivare al massimo degli errori ogni 5 secondi
const handleConnectionError = (connectionAttempts: BrokerConnectionAttempts) => {
    if (connectionAttempts.getConnectionAttempts() < MAX_RETRIES) {
        setTimeout(connect, 5000);
    } else {
        console.error("Numero massimo di tentativi di connessione raggiunto");
    }
};

// Funzione che gestisce la sottoscrizione al topic
const subscribeToTopic = (): void => {
    subscribe(TOPIC_NAMES[0]);
}

// Funzione di sottoscrizione al topic
const subscribe = (topic_name: string): void => {
    connectionAttempts.incrementSubscriptionAttempts();

    console.log("Tentativo di sottoscrizione numero: " + connectionAttempts.getSubscriptionAttempts());

    // prova a sottoscriversi al topic sul server MQTT
    connectionAttempts.getClient().subscribe(topic_name, (err: Error | null) => {
        // Gestione dell'errore
        if (err) {
            console.error('Errore di sottoscrizione:', err.message);
            handleSubscriptionError(connectionAttempts);
        } else {
            console.log("Sottoscrizione ok al topic: " + topic_name);
            
            // richiama l'handler che gestisce l'arrivo dei messaggi
            connectionAttempts.getClient().on('message', handleMessage);
        }
    });
};

// riprova a sottoscriversi fino a 10 volte ogni 5 secondi
const handleSubscriptionError = (connectionAttempts: BrokerConnectionAttempts) => {
    if (connectionAttempts.getConnectionAttempts() < MAX_RETRIES) {
        setTimeout(subscribe, 5000);
    } else {
        console.error("Numero massimo di tentativi di sottoscrizione raggiunto.");
    }
};

// Funzione che gestisce la ricezione di nuovi dati dal topic a cui è sottoscritto
const handleMessage = (receivedTopic: string, message: Buffer) => {
    // gestisce la possibilità di sottoscriversi a piu topic
    if (receivedTopic === TOPIC_NAMES[0]) {
        try {
            const data = JSON.parse(message.toString());

            const sensorData: SensorData = new SensorData(data);

            executeDB(sensorData);

            sendDataToClients(data);
        } catch (e) {
            console.error('Errore nel parsing del messaggio JSON:', e);
        }
    }
};


// Funzione di gestione dell'inserimento dei dati all'interno del db
const executeDB = (sensorData: SensorData) => {
    console.log("il sensore che sta inviando dati è: " + sensorData.getSensor());

    connection.execute(
        `SELECT *
        FROM sensori as s
        WHERE s.id LIKE ?`,
        [ sensorData.getSensor() ],
        function (err, result) {
            if (result === undefined) {
                connection.execute(
                    `INSERT INTO sensori (id, nome)
                    VALUES (?, ?)`,
                    [ sensorData.getSensor(), sensorData.getSensor() ],
                    function (err, results) {
                        console.log("Valore inserito.");
                    }
                )
            }
        }
    )    

    connection.execute(
        `INSERT INTO letture (sensore_id, temperatura, umidita, timestamp)
        VALUES (?, ?, ?, ?)`,
        [ sensorData.getSensor(), sensorData.getTemp(), sensorData.getHumidity(), sensorData.getTimestamp() ],
        function (err, results) {
            console.log("Tutto ok. Valore inserito nel database.");
        }
    )
}




