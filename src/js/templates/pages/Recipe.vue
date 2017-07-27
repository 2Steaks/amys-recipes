<template>
    <div>
        <h1>{{ recipe.title }}</h1>
        <c-image :image="recipe.image.fields" />
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
    beforeRouteEnter(to, from, next) {
        next((vm) => {
            vm.recipe = vm.$route.params.recipe.fields;
        });
    },
    created() {
        if (!Object.keys(this.recipe).length > 0) {
            this.fetchRecipe().then(() => {
                this.recipe = this.$route.params.recipe.fields;
            });
        }

    }
}
</script>