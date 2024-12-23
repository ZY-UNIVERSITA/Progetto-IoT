<template>
  <div id="app">
    <header>
      <h1>IoT Monitor</h1>
    </header>
    <div class="sensor-data">
      <div v-for="sensor in sensors" :key="sensor.id" class="sensor">
        <h3>Sensor {{ sensor.id }}</h3>
        <p>Temperature: {{ sensor.temp }}°C</p>
        <p>Humidity: {{ sensor.humidity }}%</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      sensors: [],
    };
  },
  methods: {
    fetchSensorData() {
      fetch('/api/getAllSensors')
        .then((response) => response.json())
        .then((data) => {
          this.sensors = data;
        })
        .catch((error) => {
          console.error('Errore nel recupero dei dati:', error);
        });
    },
  },
  mounted() {
    this.fetchSensorData();
    setInterval(this.fetchSensorData, 5000); // Aggiorna i dati ogni 5 secondi
  },
};
</script>

<style>
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  background: #f0f0f0;
}
header {
  color: black;
  padding: 10px;
  text-align: center;
}
.sensor-data {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
}
.sensor {
  background: white;
  padding: 20px;
  margin: 10px;
  border-radius: 5px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}
</style>
