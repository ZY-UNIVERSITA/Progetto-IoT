import { MqttClient } from "mqtt";

export class BrokerConnectionAttempts {
    private connectionAttempts: number;
    private subscriptionAttempts: number;
    private client: any;

    public getConnectionAttempts(): number {
        return this.connectionAttempts;
    }

    public incrementConnectionAttempts(): void {
        this.connectionAttempts++;
    }

    public setClient(client: MqttClient) {
        this.client = client;
    }

    public getClient(): MqttClient {
        return this.client;
    }

    public getSubscriptionAttempts(): number {
        return this.subscriptionAttempts;
    }

    public incrementSubscriptionAttempts(): void {
        this.subscriptionAttempts++;
    }

    public constructor() {
        this.connectionAttempts = 0;
        this.subscriptionAttempts = 0;
        this.client = null;
    }
}

export class SensorData {
    private sensor: number;
    private temp: number;
    private humidity: number;
    private timestamp: number[];
    
    public constructor(data: any) {
        this.sensor = data.sensor;
        this.temp = data.temp;
        this.humidity = data.humidity;
        this.timestamp = data.timestamp;
    }

    public getSensor(): number {
        return this.sensor;
    }

    public getTemp(): number {
        return this.temp;
    }

    public getHumidity(): number {
        return this.humidity;
    }

    public getTimestamp(): Date {
        return new Date(Date.UTC(this.timestamp[0], this.timestamp[1]-1, this.timestamp[2], 
            this.timestamp[3], this.timestamp[4], this.timestamp[5]));
    }
}