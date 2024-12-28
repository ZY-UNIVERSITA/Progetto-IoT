import { Request, Response } from "express";
import connection from "../utils/db";

// Ottenere una lista dei sensori da usare in una lista HTML per poter scegliere lo storico di un sensore
export const getAllSensors = async (req: Request, res: Response): Promise<void> => {
    connection.execute(
        `SELECT *
        FROM sensori as s`,
        [],
        function (err, results) {
            console.log("Va tutto bene. I dati generali del sensori sono stati inviati.");
            res.json(results);
        }
    )
}

// Si ottiene lo storico per il sensore scelto tramite HTML
export const getSensor = async (req: Request, res: Response): Promise<void> => {
    const { id } = req.params;

    console.log(id);
    
    connection.execute(
        `SELECT s.id, l.temperatura, l.umidita, l.timestamp
        FROM sensori as s JOIN letture as l ON (s.id = l.sensore_id)
        WHERE s.id = ?`,
        [id],
        function (err, results) {
            console.log(results)
            res.json(results);
        }
    )
}
