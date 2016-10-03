const $ = require('jquery')
const scApi = require('../api.js')

let xhr;

function setProviders(provider) {

    return function(dispatch, getState) {
        let indexprovider = getState().search.providers.indexOf(provider)
        if (indexprovider > -1) {
            dispatch(providerUncheck(indexprovider))

        } else {
            dispatch(providerCheck(provider))
        }


    }


}

function providerCheck(provider) {

    return {
        type: 'PROVIDER_CHECK',
        data: provider
    }
}

function providerUncheck(indexprovider) {
    return {

        type: 'PROVIDER_UNCHECK',
        data: indexprovider
    }
}

function searchKeyword(provider, keyword) {

    return function(dispatch, getState) {
        dispatch(keywordSearching(provider, keyword))
        dispatch(providerCheck(provider))
        $.get(`${scApi.base_url}/searches/${provider}`, {
            keyword: keyword
        }, function(response) {


            if (response.success) {
                dispatch(keywordResults(response.data))
            }
        }, 'json')

    }

}


function keywordSearching(provider, keyword) {
    return {

        type: 'KEYWORD_SEARCHING',
        isLoading: true,
        keyword: keyword,
        activeProvider: provider

    }
}

function keywordResults(data) {
    return {

        type: 'KEYWORD_RESULTS',
        isLoading: false,
        data: data
    }
}

function keywordMoreSearching(provider, keyword) {
    return {

        type: 'KEYWORD_MORE_SEARCHING',
        isLoadingMore: true,
        keyword: keyword,
        activeProvider: provider

    }
}

function keywordMoreResults(data) {

    return {

        type: 'KEYWORD_MORE_RESULTS',
        isLoadingMore: false,
        data: data
    }
}

function loadMore(provider) {
    return function(dispatch, getState) {
        dispatch(keywordMoreSearching(provider, getState().search.keyword))
        $.get(`${scApi.base_url}/searches/${provider}`, {
            keyword: getState().search.keyword,
            next: getState().search.results[provider].search_metadata.next_results
        }, function(response) {


            if (response.success) {
                dispatch(keywordMoreResults(response.data))
            }
        }, 'json')


    }


}

function initTrends() {

    return function(dispatch, getState) {
        if (xhr && xhr.readyState != 4) {
            xhr.abort();
        }
        dispatch({
            type: "TRENDS_LOADING",
            isLoading: true
        })
        xhr = $.get(`${scApi.base_url}/searches/trendsplace/${getState().search.location.woeid}`, function(response) {

            dispatch({
                type: "TRENDS_LOADED",
                data: response.data[0],
                isLoading: false
            })
        })


    }

}

function initPlaces() {

    return function(dispatch, getState) {

        if (getState().search.places.length < 1) {

            $.get(`${scApi.base_url}/searches/trendsavailable`, function(response) {

                dispatch({
                    type: 'PLACES_LOADED',
                    data: response.data
                })
            })

        }
    }

}

function setLocation(data) {
    return {
        type: 'SET_LOCATION',
        data: data
    }
}
module.exports = {

    setProviders: setProviders,
    searchKeyword: searchKeyword,
    loadMore: loadMore,
    initPlaces: initPlaces,
    initTrends: initTrends,
    setLocation: setLocation
}