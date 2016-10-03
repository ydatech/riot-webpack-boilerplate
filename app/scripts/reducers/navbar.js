function navbar(state = {
    notification: []
}, action) {


    switch (action.type) {
        case 'NOTIF_LOADED':
            return Object.assign({}, state, {
                notification: action.data
            })
        default:
            return state
    }
}

module.exports = navbar