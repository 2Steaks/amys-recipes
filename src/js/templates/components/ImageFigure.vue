<template>
    <div class="c-image-figure o-object-fit">
        <figure>
            <div class="c-image-figure__img">
                <img :key="image.src.small" :alt="image.alt" />
            </div>
            <figcaption>{{ image.caption }}</figcaption>
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
    props: ['image']
};
</script>