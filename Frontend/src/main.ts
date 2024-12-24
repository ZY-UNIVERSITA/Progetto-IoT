import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import type { Router }  from 'vue-router'
import './style.css'
import App from './App.vue'
import Dashboard from './pages/Dashboard.vue'
import History from './pages/History.vue'
import Config from './pages/Config.vue'

const router: Router = createRouter({
    history: createWebHistory(),
    routes: [
        { path: '/', component: Dashboard },
        { path: '/history:id', component: History },
        { path: '/config', component: Config },
    ]
});

createApp(App).use(router).mount('#app')
