<template>
    <div class="c-image">
        <img :src="image.file.url" :alt="image.description" />
    </div>
</template>

<script>

/**
 * Image Component.
 *
 * @module Image
 * @see module:modernizr
 * @mixes module:Component
 */
export default {
    props: ['image']
};
</script>