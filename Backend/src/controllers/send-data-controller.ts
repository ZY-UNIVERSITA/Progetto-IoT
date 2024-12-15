import { Request, Response } from "express";
import { connectionAttempts, TOPIC_NAMES } from "../utils/broker";
import connection from "../utils/db";

export const modify_limit = (req: Request, res: Response) => {
    const { limiteTemperatura, limiteUmidita} = req.body; // Recupera il valore 'limite' dal corpo della richiesta
    console.log("Valore limite ricevuto:", limiteTemperatura, limiteUmidita); // Stampa il valore ricevuto per conferma
    
    connectionAttempts.getClient().publish(TOPIC_NAMES[1], JSON.stringify(
        { 
            "limiteTemperatura": limiteTemperatura, 
            "limiteUmidita": limiteUmidita 
        }
    ));
    res.status(200).send("ok");
}
