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


const logo = require("file?name=logo.png!../images/logo.png")



document.addEventListener('DOMContentLoaded', function() {

    reduxStore.dispatch(actions.auth.init())

    reduxStore.subscribe(function() {
        console.log(reduxStore.getState())


    })

    actions.ui.detectScreen()
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