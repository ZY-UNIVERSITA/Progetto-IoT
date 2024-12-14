import { WebSocketServer, WebSocket } from 'ws';

let db: any[] = [];
let wss: WebSocketServer;

export const createWebSocket = (server: any) => {
    wss = new WebSocketServer({server});
    connectionToWebSocket();
}

export const sendDataToClients = (data: any) => {
  wss.clients.forEach((client: WebSocket) => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify(data));
    }
  });
};

export const connectionToWebSocket = () => {
    wss.on('connection', (ws: WebSocket) => {
        console.log('New client connected');
        ws.send('Welcome to the WebSocket server!');
        
        ws.on('message', (message: string) => {
            console.log(`Received message: ${message}`);
        });
        
        ws.on('close', () => {
            console.log('Client disconnected');
        });
    });
}
