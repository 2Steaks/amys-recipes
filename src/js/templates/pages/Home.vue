<template>
    <div class="row">
        <div class="col col-xs-12 col-sm-4 col-md-3" v-for="(item, index) in recipes" :key="index">
            <router-link :to="item.url">
                <c-image-figure :image="item.image"></c-image-figure>
            </router-link>
        </div>
    </div>
</template>

<script>
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
            recipes: [{
                title: 'Chorizo Pasta',
                url: 'recipes/chorizo-pasta',
                image: {
                    alt: 'Photo of Chorizo Pasta',
                    caption: 'Delicious Chorizo Pasta!',
                    src: {
                        small: 'http://localhost:8000/chorizo-pasta.jpg',
                        medium: 'http://localhost:8000/chorizo-pasta.jpg',
                        large: 'http://localhost:8000/chorizo-pasta.jpg'
                    }
                }
            }]
        };
    },
    created() {

    }
}
</script>