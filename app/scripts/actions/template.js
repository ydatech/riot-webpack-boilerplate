const $ = require('jquery')
const scApi = require('../api.js')
const notification = require('../notification.js')
const riot = require('riot')

let xhr

function setType(activeType) {

    return {

        type: 'TEMPLATE_SET_ACTIVE_TYPE',
        activeType: activeType
    }
}

function loadItems() {


    return function(dispatch, getState) {

        dispatch({
            type: 'TEMPLATE_RESET_ITEMS'
        })
        let params = {
            type: getState().template.activeType
        }

        if (xhr && xhr.readyState != 4) {
            xhr.abort();
        }

        dispatch({
            type: 'TEMPLATE_ITEMS_LOADING',
            isLoadingItems: true
        })
        let url = `${scApi.base_url}/templates`

        xhr = $.get(url, params, function(response) {

            if (response.success) {

                dispatch({
                    type: 'TEMPLATE_ITEMS_LOADED',
                    isLoadingItems: false,
                    data: response.data

                })

            } else {
                dispatch({
                    type: 'TEMPLATE_ITEMS_LOADING',
                    isLoadingItems: false
                })
            }
        })

    }

}

function loadMoreItems() {


    return function(dispatch, getState) {
        let params = {}
        if (xhr && xhr.readyState != 4) {
            xhr.abort();
        }

        dispatch({
            type: 'TEMPLATE_MORE_ITEMS_LOADING',
            isLoadingMoreItems: true
        })


        let url = getState().template.data._links.next.href

        xhr = $.get(url, params, function(response, textStatus, jqXhr) {
            //console.log(response)
            if (response.success) {

                dispatch({

                    type: "TEMPLATE_MORE_ITEMS_LOADED",
                    data: response.data,
                    isLoadingMoreItems: false
                })

            } else {
                dispatch({
                    type: 'TEMPLATE_MORE_ITEMS_LOADING',
                    isLoadingMoreItems: false
                })

            }

        })

    }

}


function loadPopular() {


    return function(dispatch, getState) {
        if (!getState().template.isCached) {
            dispatch({
                type: 'TEMPLATE_RESET_SEARCH_ITEMS'
            })


            if (xhr && xhr.readyState != 4) {
                xhr.abort();
            }

            dispatch({
                type: 'TEMPLATE_ITEMS_LOADING',
                isLoadingItems: true
            })
            let url = `${scApi.base_url}/templates/popular`

            xhr = $.get(url, function(response) {

                if (response.success) {

                    dispatch({
                        type: 'TEMPLATE_POPULAR_LOADED',
                        isLoadingItems: false,
                        data: response.data,
                        isCached: true

                    })

                } else {
                    dispatch({
                        type: 'TEMPLATE_ITEMS_LOADING',
                        isLoadingItems: false
                    })
                }

                if (getState().template.keyword) {

                    dispatch(searchKeyword(getState().template.keyword))
                }
            })
        } else {

            if (getState().template.keyword) {

                dispatch(searchKeyword(getState().template.keyword))
            } else {
                dispatch({
                    type: 'TEMPLATE_RESET_SEARCH_ITEMS'
                })
            }
        }

    }

}

function searchKeyword(keyword) {

    return function(dispatch, getState) {

        dispatch({
            type: 'TEMPLATE_RESET_ITEMS'
        })
        let params = {
            keyword: keyword
        }

        if (xhr && xhr.readyState != 4) {
            xhr.abort();
        }

        dispatch({
            type: 'TEMPLATE_ITEMS_LOADING',
            isLoadingItems: true
        })
        let url = `${scApi.base_url}/templates/search`

        xhr = $.get(url, params, function(response) {

            if (response.success) {

                dispatch({
                    type: 'TEMPLATE_SEARCH_LOADED',
                    isLoadingItems: false,
                    data: response.data,
                    keyword: keyword

                })

            } else {
                dispatch({
                    type: 'TEMPLATE_ITEMS_LOADING',
                    isLoadingItems: false
                })
            }
        })

    }
}

function searchMore() {


    return function(dispatch, getState) {
        let params = {}
        if (xhr && xhr.readyState != 4) {
            xhr.abort();
        }

        dispatch({
            type: 'TEMPLATE_MORE_ITEMS_LOADING',
            isLoadingMoreItems: true
        })


        let url = getState().template.search._links.next.href

        xhr = $.get(url, params, function(response, textStatus, jqXhr) {
            //console.log(response)
            if (response.success) {

                dispatch({
                    type: "TEMPLATE_MORE_SEARCH_LOADED",
                    data: response.data,
                    isLoadingMoreItems: false
                })

            } else {
                dispatch({
                    type: 'TEMPLATE_MORE_ITEMS_LOADING',
                    isLoadingMoreItems: false
                })

            }

        })

    }

}

function setKeyword(keyword) {

    return {

        type: 'TEMPLATE_SET_KEYWORD',
        keyword: keyword
    }
}

module.exports = {

    setType: setType,
    loadItems: loadItems,
    loadMoreItems: loadMoreItems,
    loadPopular: loadPopular,
    searchKeyword: searchKeyword,
    searchMore: searchMore,
    setKeyword: setKeyword
}