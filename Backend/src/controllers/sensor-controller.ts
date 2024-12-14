import { Request, Response } from "express";
import { connectionAttempts, TOPIC_NAMES } from "../utils/broker";
import connection from "../utils/db";


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

