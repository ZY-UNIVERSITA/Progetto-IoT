<script lang="ts">
import { defineComponent, onMounted, ref } from "vue";
import { useRoute } from "vue-router";
import HistoryChart from "../components/HistoryChart.vue";

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

        console.log(data);

        data.forEach(singleData => {
          chartData.value.labels.push(singleData.timestamp);
          chartData.value.temperature.push(singleData.temperatura);
          chartData.value.humidity.push(singleData.umidita);
        });

        console.log(chartData.value);
      } catch (error) {
        console.error("Error fetching history data:", error);
      }
    };

    onMounted(() => {
      fetchHistoryData();
    });

    return { sensorId, chartData };
  },
});
</script>

<template>
  <div class="history">
    <h2>Sensor History</h2>
    
    <HistoryChart
      v-if="chartData && chartData.labels.length > 0"
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
