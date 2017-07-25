const config = require('../../config');
const gulp = require('gulp');
// const gutil = require('gulp-util');

gulp.task('fonts', function() {
    gulp.src(`${config.paths.src.fonts}/**/*`)
        .pipe(gulp.dest(config.paths.dist.fonts))
});
