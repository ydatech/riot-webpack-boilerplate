function contentbox(state = {
    isLoadingBox: false,
    items: [],
    activeItem: {},
    isCached: false,
    isCreatingBox: false,
    isLoadingContent: false,
    checkAll: false
}, action) {

    switch (action.type) {
        case 'BOX_LOADING':
            return Object.assign({}, state, {
                isLoadingBox: action.isLoadingBox

            })
        case 'BOX_LOADED':
            return Object.assign({}, state, {
                isLoadingBox: action.isLoadingBox,
                isCached: action.isCached,
                items: action.items
            })
        case 'BOX_CREATING':
            return Object.assign({}, state, {
                isCreatingBox: action.isCreatingBox
            })
        case 'BOX_CREATED':
            state.items.push(action.item)
            return Object.assign({}, state, {
                items: state.items,
                isCreatingBox: action.isCreatingBox
            })
        case 'CB_CONTENT_LOADING':
            return Object.assign({}, state, {
                isLoadingContent: action.isLoadingContent
            })
        case 'CB_CONTENT_LOADED':
            return Object.assign({}, state, {
                isLoadingContent: action.isLoadingContent,
                activeItem: action.activeItem
            })
        case 'CB_RESET_CONTENT':
            return Object.assign({}, state, {
                activeItem: {}
            })
        case 'BOX_UPDATED':
            state.items[action.index] = action.data
            state.activeItem.name = action.data.name
            return Object.assign({}, state, {
                items: state.items,
                activeItem: state.activeItem
            })
        case 'BOX_DELETED':
            if (action.index > -1) {
                state.items.splice(action.index, 1)

            }
            return Object.assign({}, state, {
                items: state.items
            })
        case 'CB_UPDATED':
            state.activeItem.content[action.index] = action.data
            return Object.assign({}, state, {
                activeItem: state.activeItem
            })
        case 'CB_DELETED':
            if (action.index > -1) {
                state.activeItem.content.splice(action.index, 1)

            }
            return Object.assign({}, state, {
                activeItem: state.activeItem
            })
        case 'CB_IMPORTED':
            state.activeItem.content = action.data
            return Object.assign({}, state, {
                activeItem: state.activeItem
            })
        case 'CB_CHECK_ALL':
            state.activeItem.content.forEach(function(element, index, array) {
                element.isChecked = action.checkAll
            })
            return Object.assign({}, state, {
                checkAll: action.checkAll,
                activeItem: state.activeItem
            })
        case 'CB_CHECK_ITEM':
            state.activeItem.content[action.index].isChecked = action.checkItem
            return Object.assign({}, state, {
                checkAll: false,
                activeItem: state.activeItem

            })
        case 'CB_ALL_DELETED':
            state.activeItem.content = []
            return Object.assign({}, state, {
                activeItem: state.activeItem
            })
        case 'CB_SELECTED_DELETED':
            action.indexes.forEach(function(element, index, array) {

                state.activeItem.content.splice(element, 1)

            })
            return Object.assign({}, state, {
                activeItem: state.activeItem
            })
        default:
            return state
    }
}

module.exports = contentbox