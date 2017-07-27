<template>
    <div id="app" class="o-container">
        <c-header></c-header>
        <main class="o-container__main">
            <transition name="fade" mode="out-in" appear>
                <router-view></router-view>
            </transition>
        </main>
    </div>
</template>

<script>
import { mapActions } from 'vuex';
import CHeader from './components/Header';

/**
 * Application module.
 *
 * @module App
 * @see {@link http://router.vuejs.org/en/ Vue Router}
 * @see {@link https://vuex.vuejs.org/en/ Vuex}
 * @see module:modal
 * @see module:Header
 * @mixes Authenticated
 */
export default {
    name: 'app',
    components: {
        CHeader
    },
    /**
     * Application root component initialized
     *
     * @function created
     * @see module:user~getUser
     * @see module:Localstorage~rehydrateLocalStorage
     * @see module:Campaign~setState
     * @see module:applicationGetters~getTimezone
     * @see module:App~windowEvents
     * @see module:App~signInManagement
     */
    methods: {
        ...mapActions('recipes', [
            'runBoilerplate'
        ])
    },
    created() {
        this.runBoilerplate();
    }
}
</script>