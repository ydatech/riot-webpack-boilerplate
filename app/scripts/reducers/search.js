function search(state = {
    providers: ['twitter', 'youtube', 'flickr'],
    activeProvider: '',
    keyword: '',
    location: {
        name: 'Worldwide',
        woeid: 1
    },
    places: [],
    isLoading: false,
    isLoadingMore: false,
    results: {
        twitter: {},
        youtube: {},
        flickr: {}
    }
}, action) {
    //console.log(action.data)
    //console.log(action.type)

    switch (action.type) {
        case 'PROVIDER_CHECK':
            state.providers.push(action.data)
            return Object.assign({}, state, {
                providers: [...new Set(state.providers)]
            })
        case 'PROVIDER_UNCHECK':
            state.providers.splice(action.data, 1)
            return Object.assign({}, state, {
                providers: state.providers
            })
        case 'KEYWORD_SEARCHING':
            console.log(action)
            return Object.assign({}, state, {
                providers: state.providers,
                activeProvider: action.activeProvider,
                keyword: action.keyword,
                isLoading: action.isLoading
            })
        case 'KEYWORD_RESULTS':
            let keyword_results = {}
            if (state.activeProvider == 'twitter') {
                keyword_results.twitter = action.data
                keyword_results.youtube = state.results.youtube
                keyword_results.flickr = state.results.flickr
            } else if (state.activeProvider == 'youtube') {
                keyword_results.twitter = state.results.twitter
                keyword_results.youtube = action.data
                keyword_results.flickr = state.results.flickr

            } else if (state.activeProvider == 'flickr') {
                keyword_results.twitter = state.results.twitter
                keyword_results.youtube = state.results.youtube
                keyword_results.flickr = action.data

            }

            return Object.assign({}, state, {
                isLoading: action.isLoading,
                results: keyword_results
            })
        case 'KEYWORD_MORE_SEARCHING':
            console.log(action)
            return Object.assign({}, state, {
                providers: state.providers,
                activeProvider: action.activeProvider,
                keyword: action.keyword,
                isLoadingMore: action.isLoadingMore
            })
        case 'KEYWORD_MORE_RESULTS':
            let keyword_more_results = {}
            if (state.activeProvider == 'twitter') {
                keyword_more_results.twitter = {}
                keyword_more_results.twitter.search_metadata = action.data.search_metadata
                keyword_more_results.twitter.statuses = state.results.twitter.statuses.concat(action.data.statuses)
                keyword_more_results.youtube = state.results.youtube
                keyword_more_results.flickr = state.results.flickr
            } else if (state.activeProvider == 'youtube') {
                keyword_more_results.twitter = state.results.twitter
                keyword_more_results.youtube = {}
                keyword_more_results.youtube.search_metadata = action.data.search_metadata
                keyword_more_results.youtube.videos = state.results.youtube.videos.concat(action.data.videos)
                keyword_more_results.flickr = state.results.flickr

            } else if (state.activeProvider == 'flickr') {
                keyword_more_results.twitter = state.results.twitter
                keyword_more_results.youtube = state.results.youtube
                keyword_more_results.flickr = {}
                keyword_more_results.flickr.search_metadata = action.data.search_metadata
                keyword_more_results.flickr.photos = state.results.flickr.photos.concat(action.data.photos)

            }
            return Object.assign({}, state, {
                isLoadingMore: action.isLoadingMore,
                results: keyword_more_results
            })
        case 'TRENDS_LOADING':
            return Object.assign({}, state, {
                isLoading: action.isLoading
            })
        case 'TRENDS_LOADED':
            return Object.assign({}, state, {
                isLoading: action.isLoading,
                trends: action.data.trends,
                location: action.data.locations[0]
            })
        case 'PLACES_LOADED':
            return Object.assign({}, state, {
                places: action.data
            })
        case 'SET_LOCATION':
            return Object.assign({}, state, {
                location: action.data
            })
        default:
            return state

    }
}

module.exports = search