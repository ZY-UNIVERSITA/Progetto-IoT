import { Request, Response } from "express";
import { connectionAttempts, TOPIC_NAMES } from "../utils/broker";
import connection from "../utils/db";

export const modify_limit = (req: Request, res: Response) => {
    connectionAttempts.getClient().publish(TOPIC_NAMES[1], JSON.stringify({ name: 'felice' }));
    res.status(200).send("ok");
}
