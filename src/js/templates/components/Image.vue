<template>
    <div class="c-image">
        <img :key="image.src" :alt="alt" />
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
    props: ['image', 'alt']
};
</script>