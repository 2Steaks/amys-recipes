const config = require('../../config');
const gulp = require('gulp');
const gutil = require('gulp-util');
const imagemin = require('gulp-imagemin');

gulp.task('images', function() {
    gulp.src(`${config.paths.src.img}/**/*`)
        .pipe(config.run.clean ? imagemin() : gutil.noop())
        .pipe(gulp.dest(config.paths.dist.img))
});