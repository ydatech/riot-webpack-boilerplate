function ui(state = {
    sidebarActive: 'background',
    sidebarBoxActive: 'stock'
}, action) {

    switch (action.type) {
        case 'SIDEBAR_ACTIVATED':
            return Object.assign({}, state, {
                sidebarActive: action.data
            })
        case 'SIDEBAR_BOX_ACTIVATED':
            return Object.assign({}, state, {
                sidebarBoxActive: action.data
            })
        default:
            return state


    }


}

module.exports = ui