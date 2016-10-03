function dashboard(state = {
    isLoadingRecommended: false,
    isLoadingLatestemplates: false,
    isLoadingLatestfeeds: false,
    isLoadingStatistics: false,
    recommendedItems: [],
    latestfeedsItems: [],
    latesttemplatesItems: []
}, action) {

    console.log(action)
    switch (action.type) {
        case 'RECOMMENDED_LOADING':
            return Object.assign({}, state, {
                isLoadingRecommended: action.isLoadingRecommended
            })

        case 'RECOMMENDED_LOADED':
            return Object.assign({}, state, {
                isLoadingRecommended: action.isLoadingRecommended,
                recommendedItems: action.data
            })
        case 'LATESTFEEDS_LOADING':
            return Object.assign({}, state, {
                isLoadingLatestfeeds: action.isLoadingLatestfeeds
            })
        case 'LATESTFEEDS_LOADED':
            return Object.assign({}, state, {
                isLoadingLatestfeeds: action.isLoadingLatestfeeds,
                latestfeedsItems: action.data
            })
        case 'LATESTTEMPLATES_LOADING':
            return Object.assign({}, state, {
                isLoadingLatesttemplates: action.isLoadingLatesttemplates
            })
        case 'LATESTTEMPLATES_LOADED':
            return Object.assign({}, state, {
                isLoadingLatesttemplates: action.isLoadingLatesttemplates,
                latesttemplatesItems: action.data
            })
        default:
            return state

    }


}

module.exports = dashboard