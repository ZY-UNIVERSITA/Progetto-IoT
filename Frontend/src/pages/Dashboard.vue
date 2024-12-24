<script lang="ts">
import { defineComponent } from "vue";
import axios from "axios";
import type { Sensor } from "../../utils/types";

export default defineComponent({
  data() {
    return {
      sensors: [] as Sensor [],
    };
  },
  methods: {
    fetchSensorData() {
      axios
        .get("/api/getAllSensors")
        .then((response) => {
          this.sensors = response.data;
        })
        .catch((error) => {
          console.error("Errore nel recupero dei dati:", error);
        });
    },
  },
  mounted() {
    this.fetchSensorData();
    setInterval(this.fetchSensorData, 1500);
  },
});
</script>

<template>
    <div class="dashboard">
      <h2>Dashboard</h2>
      <div class="sensor-card" v-for="sensor in sensors">
        <h3>Sensor ID: {{ sensor.id }}</h3>
        <p>Temperature: {{ sensor.temperatura }}°C</p>
        <p>Humidity: {{ sensor.umidita }}%</p>
        <p>Last Updated: {{ sensor.timestamp }}</p>
      </div>
    </div>
</template>

<style scoped>
.dashboard {
  padding: 20px;
}
.sensor-card {
  background-color: #f9f9f9;
  border: 1px solid #ddd;
  padding: 15px;
  margin-bottom: 10px;
  border-radius: 5px;
}
</style>
