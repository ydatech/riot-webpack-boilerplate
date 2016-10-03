/* eslint-disable */

const riot = require('riot')


const actions = require('./actions/index.js')
const router = require('../scripts/router.js')
const reduxStore = require('./store.js')
const uiloader = require('./uiloader.js')
const observables = require('./observables/index.js')



require('../tags/navbar.tag')
require('../tags/sidebar.tag')
require('../tags/dashboard.tag')
require('../tags/keyword-block.tag')
require('../tags/keyword.tag')
require('../tags/twitter-results.tag')
require('../tags/youtube-results.tag')
require('../tags/flickr-results.tag')
require('../tags/topcontent-block.tag')
require('../tags/topcontent-details.tag')
require('../tags/topcontent.tag')
require('../tags/topcontent-new-source.tag')
require('../tags/media-preview.tag')
require('../tags/feed.tag')
require('../tags/feed-block.tag')
require('../tags/contentbox.tag')
require('../tags/contentbox-block.tag')
require('../tags/share-dialog.tag')
require('../tags/template.tag')
require('../tags/template-block.tag')
require('../tags/template-search.tag')
require('../tags/raw.tag')

const logo = require("file?name=logo.png!../images/logo.png")



document.addEventListener('DOMContentLoaded', function() {

    reduxStore.dispatch(actions.auth.init())

    reduxStore.subscribe(function() {
        console.log(reduxStore.getState())


    })

    actions.ui.detectScreen()


})

observables.auth.on('auth_success', function() {

    // reduxStore.dispatch(actions.socialaccounts.loadSocialaccounts())

    const navbar = riot.mount('div#navbar', 'app-navbar', {
        logo: logo,
        store: reduxStore
    })
    const sidebar = riot.mount('div#sidebar', 'app-sidebar', {
        store: reduxStore
    })
    const mediaPreview = riot.mount('div#media-preview', 'app-media-preview', {
        store: reduxStore
    })
    const shareDialog = riot.mount('div#share-dialog-container', 'app-share-dialog', {
        store: reduxStore
    })
    riot.route.base('/')
    riot.route(router.handler)
    riot.route.start(true)
})