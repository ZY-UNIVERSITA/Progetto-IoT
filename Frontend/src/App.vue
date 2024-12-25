<template>
  <div id="app">
    <header>
      <h1>IoT Monitor</h1>
      <nav>
        <router-link to="/">Dashboard</router-link>
        <router-link to="/history">History</router-link>
        <router-link to="/config">Configuration</router-link>
      </nav>
    </header>
    <router-view/>
  </div>
</template>
