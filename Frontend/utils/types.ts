export interface Sensor {
    id: number,
    nome: number,
    posizione: String,
    data_installazione: Date
}

export interface Letture {
    id: number,
    sensore_id: number,
    temperatura: number,
    umidita: number,
    timestamp: Date
}