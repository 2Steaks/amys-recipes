import Vue from 'vue';

// Router
import VueRouter from 'vue-router';
import routes from './routes';

/**
 * Vue Router configuration
 *
 * @module Router
 * @see {@link http://router.vuejs.org/en/ Vue Router}
 * @see module:routes
 */
Vue.use(VueRouter);

const router = new VueRouter({
    mode: 'history',
    routes: routes
});

export default router;