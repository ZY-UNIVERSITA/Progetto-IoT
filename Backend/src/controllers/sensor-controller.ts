import { Request, Response } from "express";
import connection from "../utils/db";

// Ottenere una lista dei sensori da usare in una lista HTML per poter scegliere lo storico di un sensore
export const getAllSensors = async (req: Request, res: Response): Promise<void> => {
    connection.execute(
        `SELECT *
        FROM sensori as s`,
        [],
        function (err, results) {
            console.log("non va bene");
            res.json(results);
        }
    )
}

// Si ottiene lo storico per il sensore scelto tramite HTML
export const getSensor = async (req: Request, res: Response): Promise<void> => {
    const { id } = req.params;

    connection.execute(
        `SELECT s.id, l.temperatura, l.umidita, l.timestamp
        FROM sensori as s JOIN letture as l ON (s.id = l.sensore_id)
        WHERE s.id LIKE ?`,
        [id],
        function (err, results) {
            res.json(results);
        }
    )
}

/* Codice da modificare in javascript puro da modificare in vue */
// WebSocket per i dati correnti 
// const socket = new WebSocket("ws://localhost:3000");

// Inizializzazione WebSocket 
// function setupWebSocket() {
//     socket.onopen = () => console.log("Connessione ok.");
//     socket.onmessage = (event) => {
//         // Parsing dei dati ricevuti
//         const data = JSON.parse(event.data);

//         // Se il dato che arrivo ha temp_limit o hum_limit significa che c'è un problema con i sensori quindi crea un popup di avviso
//         if (data.temp_limit || data.hum_limit) {
//             alert(`Il sensore ${data.sensor} ha superato il limite di ${data.temp_limit ? "temperatura" : "umidità"} 
//                 settata come limite a ${data.temp_limit ? data.temp_limit : data.hum_limit}, 
//                 registrando una valore di ${data.temp_limit ? data.temp : data.hum}`);
//         // Altrimenti semplicmente aggiungi il dato agli altri
//         } else {
//             aggiungiDatoCorrente(data);
//         }
//     };
//     socket.onerror = (error) => console.error("Errore WebSocket:", error);
// }