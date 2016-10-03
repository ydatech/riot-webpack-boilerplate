const $ = require('jquery')
const scApi = require('../api.js')

function loadSocialaccounts() {

    return function(dispatch, getState) {

        $.get(`${scApi.base_url}/socialaccounts`, function(response) {


            if (response.success) {
                dispatch(socialaccountsLoaded(response.data))
            }
        }, 'json')

    }




}

function socialaccountsLoaded(socialaccounts) {

    return {
        type: 'SOCIALACCOUNTS_LOADED',
        data: socialaccounts
    }
}

module.exports = {

    loadSocialaccounts: loadSocialaccounts
}