const $ = require('jquery')
const scApi = require('../api.js')


let xhr

function loadNotif() {


    return function(dispatch, getState) {


        if (xhr && xhr.readyState != 4) {
            xhr.abort();
        }
        let url = `${scApi.base_url}/notifications`

        xhr = $.get(url, function(response) {

            if (response.success) {

                dispatch({
                    type: 'NOTIF_LOADED',
                    data: response.data

                })

            }
        })

    }
}

module.exports = {
    loadNotif: loadNotif
}