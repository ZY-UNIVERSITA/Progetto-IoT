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
      <section class="configData">
        <label for="sensorId">Sensor ID:</label>
        <input type="number" v-model="sensorId" />
        <label for="tempLimit">Temperature Limit:</label>
        <input type="number" v-model="tempLimit" />
        <label for="humLimit">Humidity Limit:</label>
        <input type="number" v-model="humLimit" />
        <button @click="updateLimits">Update Limits</button>
      </section>
    </div>
</template>

<style lang="css" scoped>
.configData {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 20px;
  font-size: 20px;
}

input {
  padding: 5px;
  border-radius: 5%;
}

button {
  background-color: blue;
  color: white;
}
</style>