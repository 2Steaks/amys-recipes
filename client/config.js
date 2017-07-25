const _ = require("lodash");
const path = require('path');
const gutil = require("gulp-util");
// ENV
const env = gutil.env.env || 'local';
// BASE PATHS
const src = path.resolve(__dirname, './src');
const dist = path.resolve(__dirname, './dist');
const assets = `${dist}/assets`;
const publicPath = '/assets';
const base = dist;

// PATHS
var paths = {
    src: {
        js: `${src}/js`,
        json: `${src}/json`,
        img: `${src}/img`,
        icons: `${src}/icons`,
        fonts: `${src}/fonts`,
        base: src
    },
    dist: {
        css: `${assets}/css`,
        js: `${assets}/js`,
        img: `${assets}/img`,
        icons: `${assets}/img/icons`,
        fonts: `${assets}/fonts`,
        base: `${base}/`,
        public: publicPath,
        assets: assets
    }
};
// CONSTANTS
var constants = {
    default: {
        api: ''
    },
    local: {
        watch: {
            icons: [`${paths.src.icons}/*.svg`],
            images: [`${paths.src.img}/**/*`]
        },
        api: 'http://localhost:8000'
    },
    production: {
        api: 'http://recipes.devcode.ninja'
    }
};
// TASK TRIGGERS
var run = {
    default: {
        clean: false,
        server: false,
        build: false,
        icons: false,
        images: false,
        fonts: false,
        manifest: false,
    },
    local: {
        clean: true,
        server: true,
        images: true,
        icons: true,
        fonts: true,
        manifest: true
    },
    production: {
        clean: true,
        build: true,
        images: true,
        icons: true,
        fonts: true,
        manifest: true
    }
};
// TASK OPTIONS
var plugin = {
    default: {
        clean: [
            `${paths.dist.css}/*`,
            `${paths.dist.js}/*`
        ],
        svgstore: function(prefix) {
            return {
                plugins: [{
                    cleanupNumericValues: {
                        floatPrecision: 3
                    }
                }, {
                    cleanupIDs: {
                        prefix: prefix + '-',
                        minify: true
                    }
                }, {
                    cleanupListOfValues: false
                }]
            };
        }
    },
    production: {

    }
};
// MERGE CONFIG
var runOpts = _.merge({}, run.default, run[env]);
var pluginOpts = _.merge({}, plugin.default, plugin[env]);
var constantsOpts = _.merge({}, constants.default, constants[env]);

// EXPORT CONFIG
module.exports.paths = paths;
module.exports.constants = constantsOpts;
module.exports.run = runOpts;
module.exports.plugin = pluginOpts;
module.exports.env = env;