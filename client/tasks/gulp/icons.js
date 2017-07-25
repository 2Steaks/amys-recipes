const config = require('../../config');
const gulp = require("gulp");
const gutil = require("gulp-util");
const svgstore = require('gulp-svgstore');
const svgmin = require('gulp-svgmin');
const path = require('path');

gulp.task('icons', function () {
    return gulp
        .src(`${config.paths.src.icons}/*.svg`)
        .pipe(svgmin(function (file) {
            var prefix = path.basename(file.relative, path.extname(file.relative));
            return config.plugin.svgstore(prefix);
        }))
        .pipe(svgstore())
        .on('error', function(err) {
            throw new gutil.PluginError({
                plugin: 'svgstore',
                message: err
            });
        })
        .pipe(gulp.dest(config.paths.dist.icons));
});