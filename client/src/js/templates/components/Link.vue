<template>
    <div class="c-link">
        <a :href="target" target="_blank">{{ text }}</a>
    </div>
</template>

<script>

/**
 * Link Component.
 *
 * @module Link
 * @see {@link http://router.vuejs.org/en/ Vue Router}
 * @see {@link https://vuex.vuejs.org/en/ Vuex}
 * @mixes Component
 */
export default {
    props: ['target', 'text']
};
</script>