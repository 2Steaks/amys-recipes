<template>
    <div class="c-list">
        <ul>
            <li v-for="(item, index) in items" :key="index">{{ item }}</li>
        </ul>
    </div>
</template>

<script>

/**
 * List Component.
 *
 * @module List
 * @mixes Component
 */
export default {
    props: ['items']
};
</script>