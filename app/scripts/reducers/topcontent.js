function topcontent(state = {
    isLoadingTopContent: false,
    isCached: false,
    originalItems: [],
    items: [],
    activeType: '',
    activeCategory: '',
    activeSource: '',
    category: {},
    source: {},
    contentData: [],
    isLoadingContent: false,
    isLoadingMoreContent: false,
    isEditingCategory: false,
    filter: 'new',
    fbafter: null,
    countries: [],
    activeCountry: {},
    region: ''
}, action) {

    switch (action.type) {

        case 'TOPCONTENT_LOADING':
            return Object.assign({}, state, {
                isLoadingTopContent: action.isLoadingTopContent
            })
        case 'TOPCONTENT_LOADED':
            return Object.assign({}, state, {
                isLoadingTopContent: action.isLoadingTopContent,
                isCached: action.isCached,
                items: action.data,
                originalItems: action.originalData,
                category: action.activeData.category,
                source: action.activeData.source
            })
        case 'EXPAND_TYPE':
            return Object.assign({}, state, {
                activeType: action.data
            })
        case 'EXPAND_CATEGORY':
            return Object.assign({}, state, {
                activeCategory: action.data
            })
        case 'EXPAND_SOURCE':
            return Object.assign({}, state, {
                activeSource: action.data
            })
        case 'NEWCATEGORY_CREATED':
            state.items[action.indexActiveType].categories.push(action.data)
            state.originalItems[action.indexActiveType].categories.push(action.data)
            return Object.assign({}, state, {
                items: state.items,
                originalItems: state.originalItems
            })
        case 'NEWSOURCE_CREATED':
            state.items[action.indexActiveType].categories[action.indexActiveCategory].sources.push(action.data)
            state.originalItems[action.indexActiveType].categories[action.indexActiveCategory].sources.push(action.data)
            state.contentData.data[action.index].isBeingAdded = false
            state.contentData.data[action.index].isAdded = true
            return Object.assign({}, state, {
                items: state.items,
                originalItems: state.originalItems,
                contentData: state.contentData
            })
        case 'CATEGORY_UPDATED':
            state.items[action.indexActiveType].categories[action.indexActiveCategory] = action.data
            state.originalItems[action.indexActiveType].categories[action.indexActiveCategory] = action.data
            return Object.assign({}, state, {
                items: state.items,
                originalItems: state.originalItems,
                category: action.data
            })
        case 'CONTENT_LOADING':
        case 'SOURCE_LOADING':
            return Object.assign({}, state, {
                isLoadingContent: action.isLoadingContent
            })
        case 'CONTENT_LOADED':
        case 'SOURCE_LOADED':
            return Object.assign({}, state, {
                contentData: action.data,
                isLoadingContent: action.isLoadingContent
            })
        case 'MORECONTENT_LOADING':
        case 'MORESOURCE_LOADING':
            return Object.assign({}, state, {
                isLoadingMoreContent: action.isLoadingMoreContent
            })
        case 'MORECONTENT_LOADED':
            let more_results = {}
            more_results.items = state.contentData.items.concat(action.data.items)
            more_results._links = action.data._links
            more_results._meta = action.data._meta
            return Object.assign({}, state, {
                contentData: more_results,
                isLoadingMoreContent: action.isLoadingMoreContent
            })
        case 'MORESOURCE_LOADED':
            let moresource_results = {}
            moresource_results.data = state.contentData.data.concat(action.data.data)
            moresource_results.paging = action.data.paging

            return Object.assign({}, state, {
                contentData: moresource_results,
                isLoadingMoreContent: action.isLoadingMoreContent
            })
        case 'SET_FILTER':
            return Object.assign({}, state, {
                filter: action.filter
            })
        case 'SET_REGION':
            return Object.assign({}, state, {
                region: action.region
            })
        case 'EDITING_CATEGORY':
            return Object.assign({}, state, {
                isEditingCategory: action.isEditingCategory
            })
        case 'SET_FBAFTER':
            return Object.assign({}, state, {
                fbafter: action.fbafter
            })
        case 'INIT_COUNTRIES':
            return Object.assign({}, state, {
                countries: action.countries,
                activeCountry: action.activeCountry
            })

        case 'CATEGORY_DELETED':
            if (action.indexActiveCategory > -1) {
                state.items[action.indexActiveType].categories.splice(action.indexActiveCategory, 1)
                state.originalItems[action.indexActiveType].categories.splice(action.indexActiveCategory, 1)
            }
            return Object.assign({}, state, {
                items: state.items,
                originalItems: state.originalItems
            })
        case 'SOURCE_DELETED':
            if (action.indexActiveCategory > -1) {
                state.items[action.indexActiveType].categories[action.indexActiveCategory].sources.splice(action.indexActiveSource, 1)
                state.originalItems[action.indexActiveType].categories[action.indexActiveCategory].sources.splice(action.indexActiveSource, 1)
            }

            return Object.assign({}, state, {
                items: state.items,
                originalItems: state.originalItems
            })
        case 'NEWSOURCE_CREATING':
            state.contentData.data[action.index].isBeingAdded = true
            console.log('sampai disini')
            return Object.assign({}, state, {
                contentData: state.contentData
            })
        case 'RESET_CONTENT_DATA':
            return Object.assign({}, state, {
                contentData: []
            })
        default:
            return state

    }


}

module.exports = topcontent