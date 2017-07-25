const config = require('../../config');
const gulp = require('gulp');
const gutil = require('gulp-util');
const webpack = require('webpack');
const webpackConfig = require('../../webpack.config.js');

gulp.task('build', function(done) {
    if (!config.run.build) {
        done();
        return;
    }

    webpack(webpackConfig).run(function(err, stats) {
        if(err) throw new gutil.PluginError("webpack", err);
        gutil.log("[webpack]", stats.toString({
            colors: true
        }));
        done();
    });
});