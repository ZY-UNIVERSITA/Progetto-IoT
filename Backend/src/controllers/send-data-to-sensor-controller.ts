import { Request, Response } from "express";
import { connectionAttempts, TOPIC_NAMES } from "../utils/broker";

export const modify_limit = (req: Request, res: Response) => {
    // Recupera l'array 'limits' dal corpo della richiesta
    const sensor_id = req.params.sensor_id;
    const { temp, hum } = req.body; 

    // Stampa il valore ricevuto per conferma
    console.log("Valore limite ricevuto:", sensor_id, temp, hum); 
    
    connectionAttempts.getClient().publish(TOPIC_NAMES.SERVER_TO_ESP32, JSON.stringify([{
        "sensor": sensor_id,
        "temp": temp,
        "hum": hum
    }]));
    res.status(200).send("ok");
}

// Solo per fare un test
export const modify_lim = (req: Request, res: Response) => {
    connectionAttempts.getClient().publish(TOPIC_NAMES.SERVER_TO_ESP32, JSON.stringify(
        [{ 
            "sensor": 1,
            "temp": 50, 
            "hum": 10 
        }]
    ));
    res.status(200).send("ok");
}