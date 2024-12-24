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

<style>
nav {
  display: flex;
  gap: 15px;
  background: #f8f8f8;
  padding: 10px;
}
router-link {
  text-decoration: none;
  color: #000;
}
router-link:hover {
  text-decoration: underline;
}
</style>
