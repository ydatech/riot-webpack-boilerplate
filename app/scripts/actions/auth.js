const $ = require('jquery')
const scApi = require('../api.js')
const countries = require('../countries.js')
const observables = require('../observables/index.js')
const uiloader = require('../uiloader.js')

function init() {

    return function(dispatch, getState) {

        uiloader.blockUI()
        if (typeof(Storage) !== "undefined") {
            $.ajaxSetup({
                'crossDomain': true
            });
            $.get('https://dev.sociocaster.com/sso/token', function(response) {
                    // localStorage.setItem('auth', JSON.stringify(response))
                    //setup()
                    dispatch({

                        type: 'AUTH_SUCCESS',
                        data: response.data
                    })

                }, 'json')
                //console.log(localStorage.getItem('auth'))
                // Code for localStorage/sessionStorage.
            if (localStorage.getItem('auth')) {
                let authdata = JSON.parse(localStorage.getItem('auth'))
                $.ajaxSetup({
                    'beforeSend': function(xhr) {
                        xhr.setRequestHeader('Authorization', `Bearer ${authdata.jwt}`)
                    },
                    'crossDomain': true
                });

                $.get(`${scApi.base_url}/users`, {
                    expand: 'access'
                }, function(response) {
                    if (response.success) {

                        authdata['user'] = response.data
                        authdata['user']['avatar'] = `${scApi.host}${response.data.avatar}`

                        dispatch({

                            type: 'AUTH_SUCCESS',
                            data: authdata
                        })

                        observables.auth.trigger('auth_success')

                        if (getState().topcontent.activeType == 'Videos' && !getState().topcontent.region) {
                            dispatch({
                                type: 'SET_REGION',
                                region: getState().auth.user.country
                            })

                        }

                    } else {

                        dispatch({

                            type: 'AUTH_FAILED',
                            data: authdata
                        })


                    }
                    uiloader.unblockUI()

                }, 'json')


                //dispatch(setup())
            } else {
                $.get('https://dev.sociocaster.com/sso/token', function(response) {
                    // localStorage.setItem('auth', JSON.stringify(response))
                    //setup()
                    dispatch({

                        type: 'AUTH_SUCCESS',
                        data: response.data
                    })

                }, 'json')

            }
        }
    }

}

function setup() {



}

function fetch() {

    $.get('https://dev.sociocaster.com/sso/token', function(response) {
        localStorage.setItem('auth', JSON.stringify(response))
        setup()
        return {

            type: 'AUTH_SUCCESS',
            data: response.data
        }

    }, 'json')

}

module.exports = {
    init: init
}