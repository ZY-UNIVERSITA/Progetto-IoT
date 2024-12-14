import { Request, Response } from "express";
import { connectionAttempts, TOPIC_NAMES } from "../utils/broker";
import connection from "../utils/db";


export const getSensor = async (req: Request, res: Response): Promise<void> => {
    const { id } = req.params;

    console.log(id);

    connection.execute(
        `SELECT s.id, l.temperatura, l.umidita, l.timestamp
        FROM sensori as s JOIN letture as l ON (s.id = l.sensore_id)
        WHERE s.id LIKE ?`,
        [ id ],
        function (err, results) {
            res.json(results);
        }
    )
}

export const modify_limit = (req: Request, res: Response) => {
    connectionAttempts.getClient().publish(TOPIC_NAMES[1], JSON.stringify({ name: 'felice' }));
    res.status(200).send("ok");
}
