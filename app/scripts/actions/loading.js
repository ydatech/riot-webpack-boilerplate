function showLoading(reducer) {

    return {
        type: reducer + '_SHOW_LOADING',
        isLoading: true
    }
}

function hideLoading(reducer) {

    return {
        type: reducer + '_HIDE_LOADING',
        isLoading: false
    }
}

function showLoadingMore(reducer) {
    return {
        type: reducer + '_SHOW_LOADING_MORE',
        isLoadingMore: true
    }
}

function hideLoadingMore(reducer) {
    return {
        type: reducer + '_HIDE_LOADING_MORE',
        isLoadingMore: false
    }
}

module.exports = {

    showLoading: showLoading,
    hideLoading: hideLoading,

}