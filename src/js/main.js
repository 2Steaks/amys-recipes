// Babel
import 'babel-polyfill';

// Styles
import 'scss/style.scss';

// Tools
// https://github.com/vuejs/vue-router
import Vue from 'vue';

// Router
// https://github.com/vuejs/vue-router
import router from './router/Router';

// Root Template
import App from './templates/App';

// Http requests
// https://github.com/mzabriskie/axios
// https://github.com/imcvampire/vue-axios
import VueAxios from 'vue-axios';
import axios from 'axios';

// Lazy Loader
// https://github.com/hilongjw/vue-lazyload
import VueLazyload from 'vue-lazyload';

const my_axios = axios.create({
    baseURL: process.env.API
});

Vue.use(VueAxios, my_axios);
Vue.use(VueLazyload, {
    preLoad: 1
});

new Vue({
    el: '#app',
    router,
    render: h => h(App)
});