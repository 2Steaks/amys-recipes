require('require-dir')('./tasks/gulp');
const gulp = require("gulp");

gulp.task('default', ['clean', 'icons', 'images', 'fonts', 'manifest', 'server', 'build']);
