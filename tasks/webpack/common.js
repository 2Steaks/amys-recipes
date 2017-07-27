const config = require('../../config');
const postcss = require('./postcss');
const path = require('path');
const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const ScriptExtHtmlWebpackPlugin = require('script-ext-html-webpack-plugin');
const HtmlWebpackHarddiskPlugin = require('html-webpack-harddisk-plugin');

module.exports = {
    resolve: {
        extensions: ['.json', '.js', '.vue'],
        modules: [path.resolve(__dirname, config.paths.src.js), 'node_modules'],
        alias: {
            'scss': path.resolve(__dirname, '../../src/scss/'),
            'modernizr$': path.resolve(__dirname, '../../.modernizrrc'),
            'vue$': 'vue/dist/vue.common.js'
        }
    },
    entry: {
        vendor: [
            'axios',
            'vue',
            'vue-axios',
            'vue-lazyload',
            'vue-router'
        ],
        app: [
            `${config.paths.src.js}/main.js`
        ]
    },
    output: {
        path: config.paths.dist.base,
        publicPath: '/',
        filename: 'assets/js/[name]-[hash].bundle.js',
        chunkFilename: 'assets/js/[id]-[hash].bundle.js'
    },
    module: {
        rules: [{
            test: /\.modernizrrc.js$/,
            loader: "modernizr"
        }, {
            test: /\.modernizrrc(\.json)?$/,
            loader: "modernizr-loader!json-loader"
        }, {
            enforce: "pre",
            test: /\.(js|vue)$/,
            loader: "eslint-loader",
            exclude: /node_modules/
        }, {
            test: /\.js$/,
            loader: "babel-loader",
            exclude: /(\/node_modules\/|test\.js|\.spec\.js$)/
        }, {
            test: /\.(eot|svg|ttf|woff|woff2)(\?\S*)?$/,
            loader: 'file-loader',
            query: {
                name: '[name].[ext]',
                publicPath: `${config.paths.dist.public}/fonts/`,
                outputPath: 'assets/fonts/'
            }
        }, {
            test: /\.(png|jpe?g|gif|svg)(\?\S*)?$/,
            loader: 'file-loader',
            query: {
                name: '[name].[ext]',
                publicPath: `${config.paths.dist.public}/img/`,
                outputPath: 'assets/img/'
            }
        }, {
            include: /\.json$/,
            loaders: ["json-loader"]
        }]
    },
    plugins: [
        new HtmlWebpackPlugin({
            alwaysWriteToDisk: true,
            template: `${config.paths.src.base}/index.html`,
            filename: `${config.paths.dist.base}/index.html`
        }),
        new HtmlWebpackHarddiskPlugin(),
        new ScriptExtHtmlWebpackPlugin({
            defaultAttribute: 'defer'
        }),
        new webpack.optimize.CommonsChunkPlugin({
            names: ['vendor', 'runtime']
        }),
        new webpack.LoaderOptionsPlugin({
            options: {
                postcss: postcss
            }
        })
    ]
};