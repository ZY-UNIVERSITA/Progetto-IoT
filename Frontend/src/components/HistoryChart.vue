<script lang="ts">
import { defineComponent, onMounted, watch } from "vue";
import { Chart, registerables } from 'chart.js';
import type { ChartConfiguration } from "chart.js";

Chart.register(...registerables);

export default defineComponent({
  name: "HistoryChart",
  props: {
    sensorId: {
      type: Number,
      required: true,
    },
    labels: {
      type: Array as () => string[],
      required: true,
    },
    temperatureData: {
      type: Array as () => number[],
      required: true,
    },
    humidityData: {
      type: Array as () => number[],
      required: true,
    },
  },
  setup(props) {
    let chartInstance: Chart | null = null;

    const createChart = () => {
      const ctx = (document.getElementById("historyChart") as HTMLCanvasElement)?.getContext("2d");

      if (ctx) {
        const config: ChartConfiguration = {
          type: "line",
          data: {
            labels: props.labels,
            datasets: [
              {
                label: "Temperature (°C)",
                data: props.temperatureData,
                borderColor: "rgba(255, 99, 132, 1)",
                backgroundColor: "rgba(255, 99, 132, 0.2)",
                fill: true,
              },
              {
                label: "Humidity (%)",
                data: props.humidityData,
                borderColor: "rgba(54, 162, 235, 1)",
                backgroundColor: "rgba(54, 162, 235, 0.2)",
                fill: true,
              },
            ],
          },
          options: {
            responsive: true,
            animation: false,
            devicePixelRatio: 3,
            plugins: {
              legend: { position: "top" },
            },
            scales: {
              x: {
                title: { display: true, text: "Time" },
              },
              y: {
                title: { display: true, text: "Values" },
              },
            },
          },

        };

        chartInstance = new Chart(ctx, config);
      }
    };

    onMounted(() => {
      createChart();
    });

    watch(
      () => [props.labels.length, props.temperatureData.length, props.humidityData.length],
      () => {
        if (chartInstance) {
          // Aggiorna solo se i dati sono cambiati effettivamente
          chartInstance.data.labels = props.labels;
          chartInstance.data.datasets[0].data = props.temperatureData;
          chartInstance.data.datasets[1].data = props.humidityData;
          chartInstance.update();
        }
      }
    );

    return {};
  },
});
</script>

<template>
  <div class="chart-container">
    <canvas id="historyChart"></canvas>
  </div>
</template>

<style lang="css" scoped>
canvas {
  width: 2000px;
  height: auto;
}
</style>
