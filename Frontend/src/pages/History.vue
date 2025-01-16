<script lang="ts">
import { defineComponent, onMounted, ref } from "vue";
import { useRoute } from "vue-router";
import { initializeWebSocket } from "../../utils/websocket";
import HistoryChart from "../components/HistoryChart.vue";
import type { Letture } from "../../utils/types";

export default defineComponent({
  name: "History",
  components: { HistoryChart },
  setup() {
    const route = useRoute();
    const sensorId = parseInt(route.params.id as string);
    const chartData = ref<{ labels: string[]; temperature: number[]; humidity: number[] }>({
      labels: [],
      temperature: [],
      humidity: []
    });

    const fetchHistoryData = async () => {
      try {
        const response = await fetch(`/api/sensor/${sensorId}`);
        const data = await response.json();

        console.log("Dati storici caricati:", data);

        chartData.value.labels = data.map((entry: Letture) => 
          new Date(entry.timestamp).toLocaleString('it-IT', {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit'
          })
        );

        //chartData.value.labels = data.map((entry: Letture) => new Date(entry.timestamp).toLocaleString());
        chartData.value.temperature = data.map((entry: Letture) => entry.temperatura);
        chartData.value.humidity = data.map((entry: Letture) => entry.umidita);

        console.log(chartData.value);
      } catch (error) {
        console.error("Error fetching history data:", error);
      }
    };

    // Funzione per aggiornare i dati in tempo reale
    const updateChartData = (data: any) => {
      console.log("Nuovo dato ricevuto dal WebSocket:", data);

      if (data.sensor === sensorId) {
        const formattedTime = new Date(data.timestamp).toLocaleString('it-IT');

        // Crea una copia profonda dell'oggetto chartData.value
        const newChartData = JSON.parse(JSON.stringify(chartData.value));

        newChartData.labels.push(formattedTime);
        newChartData.temperature.push(data.temp);
        newChartData.humidity.push(data.hum);

        // Mantieni solo gli ultimi 20 dati per evitare sovraccarico
        if (newChartData.labels.length > 10) {
          newChartData.labels.shift();
          newChartData.temperature.shift();
          newChartData.humidity.shift();
        }

        // Assegna la nuova copia
        chartData.value = newChartData;
      }
    };

    onMounted(() => {
      fetchHistoryData(); // Carica i dati iniziali
      initializeWebSocket(updateChartData); // Inizia l'ascolto del WebSocket
    });

    return { sensorId, chartData };
  },
});
</script>

<template>
  <div class="history">
    <h2>History of Sensor n° {{ sensorId }} </h2>
    
    <HistoryChart
      v-if="chartData.labels.length > 0"
      :sensorId="sensorId"
      :labels="chartData.labels"
      :temperatureData="chartData.temperature"
      :humidityData="chartData.humidity"
    />
    
    <p v-else>Loading data...</p>
  </div>
</template>

<style scoped>
.history {
  padding: 20px;
  max-width: 900px;
  margin: 0 auto;
}

h2 {
  text-align: center;
}

.chart-container {
  width: 100%;
  height: 1000px;
}
</style>
