import { Request, Response } from "express";
import { connectionAttempts, TOPIC_NAMES } from "../utils/broker";
import connection from "../utils/db";

export const modify_limit = (req: Request, res: Response) => {
    // Recupera l'array 'limits' dal corpo della richiesta
    const { limits } = req.body; 

    // Stampa il valore ricevuto per conferma
    console.log("Valore limite ricevuto:", limits); 
    
    connectionAttempts.getClient().publish(TOPIC_NAMES.SERVER_TO_ESP32, JSON.stringify(limits));
    res.status(200).send("ok");
}

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