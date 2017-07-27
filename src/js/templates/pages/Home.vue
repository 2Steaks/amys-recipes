<template>
    <div class="row">
        <div class="col col-xs-12 col-sm-4 col-md-3" v-for="(item, index) in recipes" :key="index">
            <div @click="linkTo(item)">
                <c-image-figure :image="item.fields.image.fields" :caption="item.fields.title"></c-image-figure>
            </div>
        </div>
    </div>
</template>

<script>
import { mapGetters } from 'vuex';
import CImageFigure from '../components/ImageFigure';

/**
 * Home module
 *
 * @module Home
 * @see {@link http://router.vuejs.org/en/ Vue Router}
 * @see {@link https://vuex.vuejs.org/en/ Vuex}
 */
export default {
    components: {
        CImageFigure
    },
    data() {
        return {
            recipes: []
        };
    },
    methods: {
        ...mapGetters('recipes', [
            'getRecipes'
        ]),
        linkTo(entry) {
            this.$router.push({
                name: 'recipe', params: {
                    slug: entry.fields.slug,
                    recipe: entry
                }
            });
        }
    },
    created() {
        this.recipes = this.getRecipes();
    }
}
</script>