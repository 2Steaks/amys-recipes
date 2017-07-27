const config = require('../../config');
const gulp = require("gulp");
const gutil = require("gulp-util");
const clean = require('gulp-clean');

gulp.task('clean', function() {
    return gulp.src(config.plugin.clean, { read: false })
        .pipe(config.run.clean ? clean() : gutil.noop());
});