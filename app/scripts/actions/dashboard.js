const $ = require('jquery')
const scApi = require('../api.js')

function loadRecommended() {
    return function(dispatch, getState) {
        dispatch(recommendedLoading())
        $.get(`${scApi.base_url}/dashboards/recommended`, function(response) {

            if (response.success) {
                dispatch(recommendedLoaded(response.data))
            }
        }, 'json')
    }

}

function recommendedLoading() {

    return {

        type: 'RECOMMENDED_LOADING',
        isLoadingRecommended: true

    }
}

function recommendedLoaded(data) {

    return {
        type: 'RECOMMENDED_LOADED',
        isLoadingRecommended: false,
        data: data
    }
}

function loadLatestfeeds() {
    return function(dispatch, getState) {
        dispatch(latestfeedsLoading())
        $.get(`${scApi.base_url}/dashboards/latestfeeds`, function(response) {

            if (response.success) {
                response.data.sort(function(a, b) {
                    return parseInt(b.timestamp) - parseInt(a.timestamp)
                })
                response.data.splice(6)
                dispatch(latestfeedsLoaded(response.data))
            }
        }, 'json')

    }

}

function latestfeedsLoading() {

    return {

        type: 'LATESTFEEDS_LOADING',
        isLoadingLatestfeeds: true
    }
}

function latestfeedsLoaded(data) {

    return {
        type: 'LATESTFEEDS_LOADED',
        isLoadingLatestfeeds: false,
        data: data

    }
}


function loadLatesttemplates() {
    return function(dispatch, getState) {
        dispatch(latesttemplatesLoading())
        $.get(`${scApi.base_url}/dashboards/latesttemplates`, function(response) {

            if (response.success) {
                dispatch(latesttemplatesLoaded(response.data))
            }
        }, 'json')

    }

}

function latesttemplatesLoading() {

    return {

        type: 'LATESTTEMPLATES_LOADING',
        isLoadingLatesttemplates: true
    }
}

function latesttemplatesLoaded(data) {

    return {
        type: 'LATESTTEMPLATES_LOADED',
        isLoadingLatesttemplates: false,
        data: data

    }
}

module.exports = {

    loadRecommended: loadRecommended,
    loadLatestfeeds: loadLatestfeeds,
    loadLatesttemplates: loadLatesttemplates
}