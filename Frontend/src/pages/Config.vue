<script lang="ts">
import { defineComponent } from "vue";
import axios from "axios";

export default defineComponent({
  data() {
    return {
      sensorId: 1,
      tempLimit: 30,
      humLimit: 60,
    };
  },
  methods: {
    updateLimits() {
      axios
        .post(`/api/modifier/limit/${this.sensorId}`, {
          temp: this.tempLimit,
          hum: this.humLimit,
        })
        .then(() => {
          alert("Limiti aggiornati con successo!");
        })
        .catch((error) => {
          console.error("Errore durante l'aggiornamento dei limiti:", error);
        });
    },
  },
});
</script>

<template>
    <div class="configuration">
      <h2>Sensor Configuration</h2>
      <label for="sensorId">Sensor ID:</label>
      <input type="number" v-model="sensorId" />
      <label for="tempLimit">Temperature Limit:</label>
      <input type="number" v-model="tempLimit" />
      <label for="humLimit">Humidity Limit:</label>
      <input type="number" v-model="humLimit" />
      <button @click="updateLimits">Update Limits</button>
    </div>
</template>
