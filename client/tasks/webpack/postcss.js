/**
 * postcss
 */
const autoprefixer = require('autoprefixer'),
    cssnano = require('cssnano'),
    postcss_rgba = require('postcss-color-rgba-fallback'),
    postcss_opacity = require('postcss-opacity'),
    postcss_pseudoelements = require('postcss-pseudoelements'),
    postcss_pxtorem = require('postcss-pxtorem'),
    rucksack = require('rucksack-css');

/**
 * postcss processors
 */
const processors = [
    postcss_rgba(),
    postcss_opacity(),
    postcss_pseudoelements(),
    rucksack(),
    autoprefixer({
        browsers: ['last 5 version', 'ie >= 9']
    }),
    postcss_pxtorem({
        rootValue: 16,
        unitPrecision: 5,
        replace: false,
        selectorBlackList: ['.container', '.col', '.row']
    }),
    cssnano()
];

module.exports = processors;