<script lang="ts">
import { defineComponent, onMounted, ref } from "vue";
import { initializeWebSocket } from "../utils/websocket";

export default defineComponent({
  setup() {
    const sensorData = ref<any>(null);

    onMounted(() => {
      initializeWebSocket((data) => {
        sensorData.value = data;
        console.log("Dati ricevuti dal WebSocket:", data);
      });
    });

    return { sensorData };
  },
});
</script>

<template>
  <div id="app">
    <header>
      <h1>IoT Monitor</h1>
      <nav>
        <router-link to="/">Dashboard</router-link>
        <router-link to="/config">Configuration</router-link>
      </nav>
    </header>
    <router-view/>
  </div>
</template>

<style lang="css" scoped>
nav {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 20px;
  font-size: 20px;
}
</style>