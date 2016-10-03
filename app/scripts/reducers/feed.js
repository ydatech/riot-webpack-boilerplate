function feed(state = {
    isLoadingFeed: false,
    items: [],
    activeItem: {},
    isCached: false,
    isCreatingFeed: false,
    isLoadingContent: false
}, action) {

    switch (action.type) {

        case 'FEED_LOADING':
            return Object.assign({}, state, {
                isLoadingFeed: action.isLoadingFeed
            })
        case 'FEED_LOADED':
            return Object.assign({}, state, {
                isLoadingFeed: action.isLoadingFeed,
                items: action.items,
                isCached: action.isCached

            })
        case 'FEED_CREATING':
            return Object.assign({}, state, {
                isCreatingFeed: action.isCreatingFeed
            })
        case 'FEED_CREATED':
            state.items.push(action.item)
            return Object.assign({}, state, {
                items: state.items,
                isCreatingFeed: action.isCreatingFeed
            })
        case 'FEED_CONTENT_LOADING':
            return Object.assign({}, state, {
                isLoadingContent: action.isLoadingContent
            })
        case 'FEED_CONTENT_LOADED':
            return Object.assign({}, state, {
                isLoadingContent: action.isLoadingContent,
                activeItem: action.activeItem
            })
        case 'FEED_DELETED':
            if (action.index > -1) {
                state.items.splice(action.index, 1)

            }
            return Object.assign({}, state, {
                items: state.items
            })
        case 'FEED_RESET_CONTENT':
            return Object.assign({}, state, {
                activeItem: {}
            })
        default:
            return state
    }

}

module.exports = feed