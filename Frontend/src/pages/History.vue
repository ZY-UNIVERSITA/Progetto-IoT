<script lang="ts">
import { defineComponent } from "vue";
import axios from "axios";
import type { Sensor } from "../../utils/types";

export default defineComponent({
  data() {
    return {
      sensorId: 1, // Default ID del sensore
      history: [] as Sensor [],
    };
  },
  methods: {
    fetchHistory() {
      axios
        .get(`/api/sensors/${this.sensorId}/history`)
        .then((response) => {
          this.history = response.data;
        })
        .catch((error) => {
          console.error("Errore nel recupero dello storico:", error);
        });
    },
  },
  mounted() {
    this.fetchHistory();
  },
});
</script>

<template>
    <div class="history">
      <h2>Sensor History</h2>
      <label for="sensorId">Select Sensor ID:</label>
      <input type="number" v-model="sensorId" @change="fetchHistory"/>
      <table>
        <thead>
          <tr>
            <th>Timestamp</th>
            <th>Temperature</th>
            <th>Humidity</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="record in history">
            <td>{{ record.timestamp }}</td>
            <td>{{ record.temperatura }}°C</td>
            <td>{{ record.umidita }}%</td>
          </tr>
        </tbody>
      </table>
    </div>
</template>

<style scoped>
.history {
  padding: 20px;
}
table {
  width: 100%;
  border-collapse: collapse;
}
th, td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}
th {
  background-color: #f2f2f2;
}
</style>
