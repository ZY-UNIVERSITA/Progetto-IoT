<script lang="ts">
import { defineComponent, ref, onMounted } from "vue";
import type { Sensor } from "../../utils/types";

export default defineComponent({
  setup() {
    const sensors = ref<Sensor[]>([]);

    const fetchSensors = async () => {
      const response = await fetch("/api/getAllSensors");
      const data = await response.json();
      console.log(data);

      sensors.value = data.map((sensor: Sensor) => ({
        id: sensor.id,
        nome: sensor.nome,
        posizione: sensor.posizione,
        data_installazione: sensor.data_installazione
      }));
    };

    const formatDate = (date: Date) => {
      return new Date(date).toLocaleString('it-IT');
    };

    const goToHistory = (sensorId: number) => {
      window.location.href = `/history/${sensorId}`;
    };

    onMounted(() => {
      fetchSensors();
    });

    return { sensors, goToHistory, formatDate };
  },
});
</script>

<template>
  <div id="dashboard">
    <h2>Sensors Dashboard</h2>
    <div class="sensor-list">
      <div v-for="sensor in sensors" class="sensor-card">
        <h3>Sensor ID: {{ sensor.id }}</h3>
        <p>Position: {{ sensor.posizione }}</p>
        <p>Installation Date: {{ formatDate(sensor.data_installazione) }}</p>
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
