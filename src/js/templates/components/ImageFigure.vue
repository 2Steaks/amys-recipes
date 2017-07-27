<template>
    <div class="c-image-figure o-object-fit">
        <figure>
            <div class="c-image-figure__img">
                <img :src="image.file.url" :alt="image.description" />
            </div>
            <figcaption>{{ caption }}</figcaption>
        </figure>
    </div>
</template>

<script>

/**
 * Image Figure Component.
 *
 * @module ImageFigure
 * @see module:modernizr
 * @mixes module:Component
 */
export default {
    props: ['image', 'caption']
};
</script>