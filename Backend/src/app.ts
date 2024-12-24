import express, { Express, NextFunction, Request, Response } from "express";
import mqtt, { MqttClient } from "mqtt";
import path from "path";
import { connectionToWebSocket, createWebSocket } from "./utils/websocket";
import { connectToBroker } from "./utils/broker";
import sendDataRouter from "./routes/send-data-to-sensor-router"
import sensorRouter from "./routes/sensor-route"
import bodyParser from "body-parser"


// Configurazione dell'applicazione Express
const app: Express = express();
const port: number = 3000;


// Middleware per servire file statici
app.use(express.static("public"));
app.use(express.static("dist-frontend"));

// Middleware per il parsing del body delle richieste
app.use(express.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Middleware per l'utilizzo dei router
app.use(sensorRouter);
app.use(sendDataRouter);

connectToBroker();

app.get("/", (req: Request, res: Response) => {
  res.sendFile(path.join(__dirname, '../public/frontend.html'));
});

// Gestione delle rotte non esistenti (404)
app.use((req: Request, res: Response, next: NextFunction) => {
  res.setHeader("Content-Type", "text/plain");
  res.status(404).send("Ops... Pagina non trovata");
});

const server = app.listen(port, () => {
  console.log(`In ascolto all'indirizzo: http://localhost:${port}`);
});

createWebSocket(server);

