<template>
    <div>
        Recipe!
    </div>
</template>

<script>
import CImage from '../components/Image';

/**
 * Home module
 *
 * @module Home
 * @see {@link http://router.vuejs.org/en/ Vue Router}
 * @see {@link https://vuex.vuejs.org/en/ Vuex}
 */
export default {
    components: {
        CImage
    },
    data() {
        return {
            recipe: {}
        };
    },
    created() {
        this.axios.get(`/recipes/${this.$route.params.recipe}.json`).then((data) => {
            this.recipe = data.data;
        });
    }
}
</script>