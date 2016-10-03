const redux = require('redux')
const auth = require('./auth.js')
const socialaccounts = require('./socialaccounts.js')
const ui = require('./ui.js')
const search = require('./search.js')
const dashboard = require('./dashboard.js')
const topcontent = require('./topcontent.js')
const feed = require('./feed.js')
const contentbox = require('./contentbox.js')
const template = require('./template.js')
const navbar = require('./navbar.js')
const reducer = redux.combineReducers({
  auth,
  socialaccounts,
  ui,
  search,
  dashboard,
  topcontent,
  feed,
  contentbox,
  template,
  navbar
})

module.exports = reducer