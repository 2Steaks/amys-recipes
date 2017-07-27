import Vue from 'vue';
import Vuex from 'vuex';

// modules
import * as modules from './modules';

Vue.use(Vuex);

const store = new Vuex.Store({
    modules: modules
});

// webpack hot module replacement
if (module.hot) {
    module.hot.accept([
        './modules/recipes'
    ], () => {
        const newRecipes = require('./modules/recipes').default;

        store.hotUpdate({
            modules: {
                recipes: newRecipes
            }
        });
    });
}

export default store;