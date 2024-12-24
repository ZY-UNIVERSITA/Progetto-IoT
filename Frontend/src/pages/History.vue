<script lang="ts">
  import { defineComponent, ref, onMounted } from "vue";
  import HistoryChart from "../components/HistoryChart.vue";
  import { useRoute } from "vue-router";
  import axios from "axios";
  
  export default defineComponent({
    name: "History",
    components: { HistoryChart },
    setup() {
      const sensorId = parseInt(useRoute().params.id as string, 10);
      const labels = ref<string[]>([]);
      const temperatureData = ref<number[]>([]);
      const humidityData = ref<number[]>([]);
      const loaded = ref(false);
  
      const fetchData = async () => {
        try {
          const response = await axios.get(`/api/sensor/${sensorId}`);
          const { data } = response;
          labels.value = data.map((entry: any) => entry.timestamp);
          temperatureData.value = data.map((entry: any) => entry.temperature);
          humidityData.value = data.map((entry: any) => entry.humidity);
          loaded.value = true;
        } catch (error) {
          console.error("Errore nel recupero dei dati:", error);
          loaded.value = false;
        }
      };
  
      onMounted(fetchData);
  
      return { sensorId, labels, temperatureData, humidityData, loaded };
    },
  });
</script>

<template>
    <div>
      <h2>History for Sensor ID: {{ sensorId }}</h2>
      <HistoryChart
        v-if="loaded"
        :sensorId="sensorId"
        :labels="labels"
        :temperatureData="temperatureData"
        :humidityData="humidityData"
      />
      <p v-else>Loading data...</p>
    </div>
</template>
  
<style scoped>
  h2 {
    text-align: center;
    margin-bottom: 20px;
  }
</style>
