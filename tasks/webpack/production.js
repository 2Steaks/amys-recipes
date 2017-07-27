const config = require('../../config');
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const webpack = require('webpack');

module.exports = {
    stats: 'errors-only',
    devtool: 'source-map',
    module: {
        rules: [{
            test: /\.css$/,
            loader: ExtractTextPlugin.extract({
                fallback: 'style-loader',
                use: [{
                    loader: 'css-loader'
                }]
            })
        }, {
            test: /\.scss$/,
            exclude: /node_modules/,
            loader: ExtractTextPlugin.extract({
                fallback: 'style-loader',
                use: [{
                    loader: 'css-loader',
                    options: {
                        autoprefixer: false,
                        url: false
                    }
                }, {
                    loader: 'postcss-loader'
                }, {
                    loader: 'sass-loader',
                    options: {
                        data: `$asset-base-path: '${config.paths.dist.public}';`
                    }
                }]
            })
        }, {
            test: /\.vue$/,
            loader: 'vue-loader',
            exclude: /node_modules/,
            options: {
                loaders: {
                    css: ExtractTextPlugin.extract({
                        fallback: 'vue-style-loader',
                        use: [{
                            loader: "css-loader",
                            options: {
                                autoprefixer: false,
                                url: false
                            }
                        }, {
                            loader: "sass-loader"
                        }]
                    })
                }
            }
        }]
    },
    plugins: [
        new webpack.LoaderOptionsPlugin({
            minimize: true,
            debug: false
        }),
        new webpack.optimize.UglifyJsPlugin({
            sourceMap: true,
            compress: {
                warnings: false,
                drop_console: true
            },
            comments: false
        }),
        new ExtractTextPlugin("assets/css/[name]-[hash].min.css"),
        new webpack.DefinePlugin({
            'process.env': {
                DEBUG: false,
                NODE_ENV: '"production"',
                ASSET_PATH: JSON.stringify(config.paths.dist.public),
                API: JSON.stringify(config.constants.api)
            }
        })
    ]
};