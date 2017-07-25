const merge = require('webpack-merge');
var config = require('./config');
var common = require('./tasks/webpack/common');
var development = require('./tasks/webpack/development');
var production = require('./tasks/webpack/production');
var setup;

switch (config.env) {
    case 'local':
        setup = merge(common, development);
        break;
    default:
        setup = merge(common, production);
        break;
}

module.exports = setup;