const config = require('../../config');
const gulp = require('gulp');
//const gutil = require('gulp-util');
const webpack = require('webpack');
const webpackConfig = require('../../webpack.config.js');
const webpackDevMiddleware = require('webpack-dev-middleware');
const webpackHotMiddleware = require('webpack-hot-middleware');
const modRewrite = require('connect-modrewrite');
const browserSync = require('browser-sync').create();
const stripAnsi = require('strip-ansi');

gulp.task('server', function(done) {
    if (!config.run.server) {
        done();
        return;
    }

    let bundler = webpack(webpackConfig);

    bundler.plugin('done', function(stats) {
        if (stats.hasErrors() || stats.hasWarnings()) {
            return browserSync.sockets.emit('fullscreen:message', {
                title: 'Webpack Error:',
                body: stripAnsi(stats.toString()),
                timeout: 100000
            });
        }
    });

    browserSync.init({
        server: {
            cors: true,
            baseDir: config.paths.dist.base,
            middleware: [
                webpackDevMiddleware(bundler, webpackConfig.devServer),
                webpackHotMiddleware(bundler),
                modRewrite([
                    '!\\.\\w+$ /index.html [L]'
                ])
            ],
            plugins: ['bs-fullscreen-message']
        }
    }, function() {
        done();
    });

    if (config.constants.watch) {
        Object.keys(config.constants.watch).forEach(function(key) {
            gulp.task(`reload-${key}`, [key], function(done) {
                browserSync.reload();
                done();
            });
            gulp.watch(config.constants.watch[key], [`reload-${key}`]);
        });
    }
});

