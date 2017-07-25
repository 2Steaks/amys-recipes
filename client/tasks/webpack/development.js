const config = require('../../config');
const webpack = require('webpack');
const packageJosn = require("../../package.json");

module.exports = {
    entry: {
        vendor: [
            'webpack/hot/dev-server',
            'webpack-hot-middleware/client'
        ],
        app: [
            'webpack/hot/dev-server',
            'webpack-hot-middleware/client'
        ]
    },
    module: {
        rules: [{
            test: /\.vue$/,
            loader: 'vue-loader',
            options: {
                loaders: {
                    'scss': 'vue-style-loader!css-loader!sass-loader',
                    'sass': 'vue-style-loader!css-loader!sass-loader?indentedSyntax'
                }
            }
        }, {
            test: /\.css$/,
            loader: 'style-loader!css-loader'
        }, {
            test: /\.scss$/,
            use: [{
                loader: 'style-loader',
            }, {
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
        }]
    },
    devServer: {
        inline: true,
        contentBase: config.paths.dist.base,
        publicPath: '/',
        filename: '[name].bundle.js',
        port: 3000,
        historyApiFallback: {
            index: 'index.html'
        },
        noInfo: true,
        stats: 'errors-only'
    },
    devtool: '#eval-source-map',
    watchOptions: {
        ignored: /node_modules/
    },
    performance: {
        hints: false
    },
    plugins: [
        new webpack.HotModuleReplacementPlugin(),
        new webpack.NoEmitOnErrorsPlugin(),
        new webpack.DefinePlugin({
            'process.env': {
                DEBUG: true,
                VERSION: JSON.stringify(packageJosn.version),
                PROJECT_NAME: JSON.stringify(packageJosn.name),
                NODE_ENV: JSON.stringify("development"),
                ASSET_PATH: JSON.stringify(config.paths.dist.public),
                API: JSON.stringify(config.constants.api)
            }
        })
    ]
};
