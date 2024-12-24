<script lang="ts">
  import { defineComponent, onMounted, watch } from "vue";
  import { Chart } from "chart.js";
  import type { ChartConfiguration } from "chart.js";
  
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
              plugins: {
                legend: {
                  position: "top",
                },
              },
              scales: {
                x: {
                  title: {
                    display: true,
                    text: "Time",
                  },
                },
                y: {
                  title: {
                    display: true,
                    text: "Values",
                  },
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
        () => [props.labels, props.temperatureData, props.humidityData],
        () => {
          if (chartInstance) {
            chartInstance.destroy();
            createChart();
          }
        }
      );
    },
  });
</script>

<template>
    <div class="chart-container">
      <h3>Sensor ID: {{ sensorId }}</h3>
      <canvas id="historyChart"></canvas>
    </div>
</template>
  
<style scoped>
  .chart-container {
    width: 100%;
    max-width: 800px;
    margin: 0 auto;
  }
</style>
  