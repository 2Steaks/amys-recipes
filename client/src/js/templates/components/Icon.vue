<template>
    <div class="c-icon" v-bind:class="iconClass">
        <svg class="c-icon__svg">
            <use :xlink:href="iconPath" />
        </svg>
    </div>
</template>

<script>
/**
 * Icon Component.
 *
 * @module Icon
 */
export default {
    props: ['svg'],
    computed: {
        /**
         * add icon class based on it's name
         *
         * @function iconClass
         * @returns {string} icon class name
         */
        iconClass() {
            return `c-icon--${ this.svg }`;
        },
        /**
         * path to svg file
         *
         * @function iconPath
         * @returns {string} path
         */
        iconPath() {
            return `${ process.env.ASSET_PATH }/img/icons/icons.svg#${ this.svg }`;
        }
    }
};
</script>