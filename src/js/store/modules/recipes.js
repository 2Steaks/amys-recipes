import { createClient } from 'contentful';

const SPACE_ID = 'ia736gb0aup3'
const ACCESS_TOKEN = '7846c7f12cf93a585d3199ec24c746c0b6970e0a70148f173d90a9b516d2c8b7'

const client = createClient({
    // This is the space ID. A space is like a project folder in Contentful terms
    space: SPACE_ID,
    // This is the access token for this space. Normally you get both ID and the token in the Contentful web app
    accessToken: ACCESS_TOKEN
});

const state = {
    recipes: []
};

const getters = {
    getRecipes: state => state.recipes
};

const actions = {
    runBoilerplate: ({ dispatch }) => {
        dispatch('fetchContentTypes')
            .then((contentTypes) => dispatch('displayEntries', contentTypes))
            .catch((error) => {
                console.log('\nError occurred:');

                if (error.stack) {
                    console.error(error.stack);
                    return;
                }

                console.error(error);
            });
    },
    displayEntries: ({ dispatch, commit }, contentTypes) => {
        return Promise.all(contentTypes.map((contentType) => {
            return dispatch('fetchEntriesForContentType', contentType)
                .then((entries) => {
                    entries.forEach((entry) => {
                        commit('addRecipes', {
                            id: entry.sys.id,
                            fields: entry.fields
                        });
                    });
                })
        }))
    },
    fetchContentTypes: () => {
        return client.getContentTypes()
            .then((response) => response.items)
            .catch((error) => {
                console.error(error);
            });
    },
    fetchEntriesForContentType: ({ commit }, contentType) => {
        return client.getEntries({
                limit: 6,
                content_type: contentType.sys.id
            })
            .then((response) => response.items)
            .catch((error) => {
                console.log(`\nError occurred while fetching Entries for ${contentType.name}:`);
                console.error(error)
            });
    },
    fetchRecipe: ({ dispatch }, id) => {
        return new Promise((resolve, reject) => {
            if (!id) {
                reject('ID required');
                return;
            }

            client.getEntry(id)
                .then(entry => {
                    dispatch('fetchAsset', entry).then((asset) => {
                        console.log(asset);
                        entry.fields.image = asset;

                        resolve({
                            id: entry.sys.id,
                            fields: entry.fields,
                        });
                    });
                })
                .catch(console.error);
        });
    },
    fetchAsset: ({ commit }, entry) => {
        return new Promise((resolve, reject) => {
            if (!entry) {
                reject('Entry required');
                return;
            }

            client.getEntry(entry.fields.image.sys.id)
                .then(asset => resolve(asset))
                .catch(console.error);
        });
    }
};

const mutations = {
    addRecipes: (state, entry) => {
        state.recipes.push(entry);
    }
};

export default {
    namespaced: true,
    state,
    getters,
    actions,
    mutations
};