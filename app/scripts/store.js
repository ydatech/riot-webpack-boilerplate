const redux = require('redux')
const thunk = require('redux-thunk').default
const reducer = require('./reducers/index.js')


const reduxStore = redux.createStore(
  reducer,
  redux.applyMiddleware(thunk)
)

module.exports = reduxStore
