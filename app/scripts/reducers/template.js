function template(state = {
    isLoadingItems: false,
    isLoadingMoreItems: false,
    data: [],
    popular: [],
    activeType: '',
    search: [],
    keyword: '',
    isCached: false
}, action) {

    switch (action.type) {
        case 'TEMPLATE_SET_ACTIVE_TYPE':
            return Object.assign({}, state, {
                activeType: action.activeType
            })
        case 'TEMPLATE_ITEMS_LOADING':
            return Object.assign({}, state, {
                isLoadingItems: action.isLoadingItems
            })
        case 'TEMPLATE_ITEMS_LOADED':
            return Object.assign({}, state, {
                isLoadingItems: action.isLoadingItems,
                data: action.data
            })
        case 'TEMPLATE_RESET_ITEMS':
            return Object.assign({}, state, {
                data: []
            })
        case "TEMPLATE_MORE_ITEMS_LOADING":
            return Object.assign({}, state, {
                isLoadingMoreItems: action.isLoadingMoreItems
            })
        case "TEMPLATE_MORE_ITEMS_LOADED":
            let more_items = {}
            more_items.items = state.data.items.concat(action.data.items)
            more_items._links = action.data._links
            more_items._meta = action.data._meta
            return Object.assign({}, state, {
                isLoadingMoreItems: action.isLoadingMoreItems,
                data: more_items
            })
        case 'TEMPLATE_POPULAR_LOADED':
            return Object.assign({}, state, {
                isLoadingItems: action.isLoadingItems,
                popular: action.data,
                isCached: action.isCached
            })
        case 'TEMPLATE_SEARCH_LOADED':
            return Object.assign({}, state, {
                isLoadingItems: action.isLoadingItems,
                search: action.data,
                keyword: action.keyword
            })
        case "TEMPLATE_MORE_SEARCH_LOADED":
            let more_search_items = {}
            more_search_items.items = state.search.items.concat(action.data.items)
            more_search_items._links = action.data._links
            more_search_items._meta = action.data._meta
            return Object.assign({}, state, {
                isLoadingMoreItems: action.isLoadingMoreItems,
                search: more_search_items
            })
        case 'TEMPLATE_SET_KEYWORD':
            return Object.assign({}, state, {
                keyword: action.keyword
            })
        case 'TEMPLATE_RESET_SEARCH_ITEMS':
            return Object.assign({}, state, {
                search: []
            })
        default:
            return state

    }
}

module.exports = template