import 'bootstrap/dist/css/bootstrap.min.css';
import '@fortawesome/fontawesome-free/css/all.min.css';
// import './assets/slick-1.8.1/slick/slick.css';
import './assets/main.css';
import './assets/index.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
// import pinia from './store/store';

import { createApp } from 'vue'
import { createPinia } from 'pinia';
import App from './App.vue'
import router from './router'
import axios from 'axios'
import VueAxios from 'vue-axios'
import cors from 'cors';
import { provideCartService } from './services/cart.service';
// import GAuth  from 'vue3-google-oauth2';
import vue3GoogleLogin from 'vue3-google-login'

const app = createApp(App);

// const gAuthOptions = { clientId: '137267181828-nhfes7fqk7gkeguok8utbjmos597ovof.apps.googleusercontent.com', scope: 'email', prompt: 'consent', fetch_basic_profile: false }
// app.use(GAuth, gAuthOptions)
app.use(vue3GoogleLogin, {
    clientId: '137267181828-nhfes7fqk7gkeguok8utbjmos597ovof.apps.googleusercontent.com'
  })

// Provide VueAxios and axios
app.use(VueAxios, axios);

// Use router and cors
app.use(router);
app.use(cors);

// Create and use Pinia store
const pinia = createPinia();
app.use(pinia);


// Provide cartService
app.provide('cartService', provideCartService());

// Mount the app
app.mount('#app');
