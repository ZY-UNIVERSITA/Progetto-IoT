<script lang="ts">
import { defineComponent, ref, onMounted } from "vue";
import type { Sensor } from "../../utils/types";
import { initializeWebSocket } from "../../utils/websocket";

export default defineComponent({
  setup() {
    // Tipizza sensors come un array di oggetti di tipo Sensor
    const sensors = ref<Sensor[]>([]);

    // Funzione per recuperare i sensori
    const fetchSensors = async () => {
      const response = await fetch("/api/getAllSensors");
      const data = await response.json();
      
      console.log(data);

      sensors.value = data.map((sensor: Sensor) => ({
        id: sensor.id,
        position: sensor.posizione,
        installationDate: sensor.data_installazione,
      }));
    };

    const goToHistory = (sensorId: number) => {
      window.location.href = `/history/${sensorId}`;
    };

    onMounted(() => {
      initializeWebSocket((data: any) => {
        console.log("Real-time data received:", data);
      });
      fetchSensors();
    });

    return { sensors, goToHistory };
  },
});
</script>

<template>
  <div id="dashboard">
    <h2>Sensors Dashboard</h2>
    <div class="sensor-list">
      <div v-for="sensor in sensors" class="sensor-card">
        <h3>Sensor ID: {{ sensor.id }}</h3>
        <p>Position: {{ sensor.position }}</p>
        <p>Installation Date: {{ sensor.installationDate }}</p>
        <button @click="goToHistory(sensor.id)">View History</button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.sensor-list {
  display: flex;
  flex-wrap: wrap;
  gap: 15px;
  margin-top: 20px;
}

.sensor-card {
  border: 1px solid #ddd;
  padding: 15px;
  border-radius: 8px;
  background: #f9f9f9;
  max-width: 200px;
  text-align: center;
  box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
}

button {
  margin-top: 10px;
  padding: 5px 10px;
  border: none;
  background-color: #007bff;
  color: white;
  border-radius: 4px;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}
</style>
