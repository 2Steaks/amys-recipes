// Main templates
import * as Pages from '../templates/pages';

/**
 * Integrated routes
 *
 * @module routes
 * @see module:templates/pages/Index
 * @see module:templates/pages/authentication/index
 * @see module:templates/pages/Register
 * @see module:templates/pages/Sales
 * @see module:templates/pages/game/index
 */
export default [{
    path: '/',
    name: 'default',
    component: Pages.Home,
}, {
    path: '/recipes/:recipe',
    name: 'recipe',
    component: Pages.Recipe
}];