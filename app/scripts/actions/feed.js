const $ = require('jquery')
const scApi = require('../api.js')
const notification = require('../notification.js')
const riot = require('riot')

let xhrCreate
let xhrDelete
let xhr

function initFeedList() {

    return function(dispatch, getState) {
        if (!getState().feed.isCached) {
            dispatch({
                type: 'FEED_LOADING',
                isLoadingFeed: true
            })

            $.get(`${scApi.base_url}/feeds`, function(response) {
                let items = {}
                if (response.success) {
                    items = response.data.items

                }
                dispatch({
                    type: 'FEED_LOADED',
                    isLoadingFeed: false,
                    items: items,
                    isCached: true
                })

            })

        }
    }
}

function createNewFeed(url) {
    return function(dispatch, getState) {

        let params = {
            feed_url: url
        }
        if (xhrCreate && xhrCreate.readyState != 4) {
            xhrCreate.abort();
        }

        dispatch({
            type: 'FEED_CREATING',
            isCreatingFeed: true
        })
        xhrCreate = $.post(`${scApi.base_url}/feeds`, params, function(response) {

            if (response.success) {
                dispatch({
                    type: 'FEED_CREATED',
                    item: response.data,
                    isCreatingFeed: false

                })

                notification(`<b>${url}</b> has been added to your feed list`, 'success')
                riot.route(`feed/${response.data.id}`)
            } else {
                dispatch({
                    type: 'FEED_CREATING',
                    isCreatingFeed: false
                })
                if (typeof response.data.message !== 'undefined')
                    notification(response.data.message, 'error')
                else if (typeof response.data[0] !== 'undefined')
                    notification(response.data[0].message, 'error')
                else
                    notification('Something went wrong, please try again!', 'error')

            }
        })
    }



}

function deleteFeed() {

    return function(dispatch, getState) {
        if (xhrDelete && xhrDelete.readyState != 4) {
            xhrDelete.abort();
        }

        xhrDelete = $.ajax({

            url: `${scApi.base_url}/feeds/${getState().feed.activeItem.id}`,
            method: 'DELETE',
            statusCode: {
                204: function() {
                    //alert( "success" );
                    notification(`<b>${getState().feed.activeItem.site_title}</b> has been deleted!`, 'success')
                    let index = getState().feed.items.findIndex(function(item) {
                        return item.id == getState().feed.activeItem.id
                    })
                    dispatch({
                        type: 'FEED_DELETED',
                        index: index

                    })

                    riot.route('feed')
                }
            }
        })

    }

}

function loadContent(data) {
    return function(dispatch, getState) {

        dispatch({
            type: 'FEED_RESET_CONTENT'
        })
        let params = {
            expand: 'content',
            type: 'lastthree'
        }

        if (xhr && xhr.readyState != 4) {
            xhr.abort();
        }

        dispatch({
            type: 'FEED_CONTENT_LOADING',
            isLoadingContent: true
        })
        let url = `${scApi.base_url}/feeds`
        let mode = 'all'
        if (typeof data.id !== 'undefined') {
            url = `${scApi.base_url}/feeds/${data.id}`
            mode = 'detail'
        }

        xhr = $.get(url, params, function(response) {

            if (response.success) {
                let activeItem = {}
                if (mode == 'all') {

                    activeItem = {
                        site_title: 'Latest Posts From Your Last Three Feeds'
                    }
                    activeItem.content = []

                    response.data.items.forEach(function(item) {

                        activeItem.content = activeItem.content.concat(item.content)

                    })

                    activeItem.content.sort(function(a, b) {
                        return parseInt(b.timestamp) - parseInt(a.timestamp)
                    })
                } else {
                    activeItem = response.data
                }

                dispatch({
                    type: 'FEED_CONTENT_LOADED',
                    isLoadingContent: false,
                    activeItem: activeItem

                })

            } else {
                dispatch({
                    type: 'FEED_CONTENT_LOADING',
                    isLoadingContent: false
                })
            }
        })
    }

}
module.exports = {

    initFeedList: initFeedList,
    createNewFeed: createNewFeed,
    deleteFeed: deleteFeed,
    loadContent: loadContent
}