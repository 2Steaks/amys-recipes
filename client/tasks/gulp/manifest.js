const config = require('../../config');
const gulp = require('gulp');

gulp.task('manifest', function() {
    gulp.src(`${config.paths.src.base}/manifest.json`)
        .pipe(gulp.dest(config.paths.dist.base))
});
