const $ = require('jquery')
const scApi = require('../api.js')
const countries = require('../countries.js')
const observables = require('../observables/index.js')
const uiloader = require('../uiloader.js')

function init() {

    return function(dispatch, getState) {
        ////"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE0NzQ5MzA1MjUsImp0aSI6IlJHZGZiRjlwTm14V1ZWOVNZMmxrTXpCWE4yVmZiekF6TXpsbGJYY3laSEE9IiwiaXNzIjoic29jaW9jYXN0ZXIuY29tIiwibmJmIjoxNDc0OTMwNTI2LCJleHAiOjE0NzcwMDQxMjYsImRhdGEiOnsiaWQiOiI1MiIsInVzZXJuYW1lIjoieWRhdGVjaCIsImVtYWlsIjoieXVkYXN1a21hbmFAc29jaW9jYXN0ZXIuY29tIn19.aw3W1AMFRwFU8Z0CltSKeExW5mEROMEy37z7IYb1IG1cLC-wmLnm2FO6AyCu5tyEJfkjCX0iwRihFVV2bAdcKA",
        //"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE0NzQ0MzEzOTYsImp0aSI6IllVRnVWM2RpZERZemFuQnpiVlZMZURCNGVIVlBkMnRNUTBsS09VdHBZbFk9IiwiaXNzIjoiZGV2LnNvY2lvY2FzdGVyLmNvbSIsIm5iZiI6MTQ3NDQzMTM5NywiZXhwIjoxNDc2NTA0OTk3LCJkYXRhIjp7ImlkIjoiMTAyIiwidXNlcm5hbWUiOiJ5dWRhc3VrbWFuYSIsImVtYWlsIjoieXVkYS5zdWttYW5hLjE5OTJAZ21haWwuY29tIiwiYXZhdGFyIjoiXC91cGxvYWRcL2ltYWdlc1wvcHJvZmlsZXNcLzEwMl9wcm9maWxlXzE0MzgxNTc2ODkucG5nIn19.Bx76H_ZZpA5qrE0fNakTSi-u8JL5YSY67ISTAqNLT7HvvLbnfhVp3J4abmZfJNu9F-5dWd99i08c07aP4_hJTQ",

        uiloader.blockUI()
        if (typeof(Storage) !== "undefined") {
            const userdata = {
                jwt: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE0NzQ0MzEzOTYsImp0aSI6IllVRnVWM2RpZERZemFuQnpiVlZMZURCNGVIVlBkMnRNUTBsS09VdHBZbFk9IiwiaXNzIjoiZGV2LnNvY2lvY2FzdGVyLmNvbSIsIm5iZiI6MTQ3NDQzMTM5NywiZXhwIjoxNDc2NTA0OTk3LCJkYXRhIjp7ImlkIjoiMTAyIiwidXNlcm5hbWUiOiJ5dWRhc3VrbWFuYSIsImVtYWlsIjoieXVkYS5zdWttYW5hLjE5OTJAZ21haWwuY29tIiwiYXZhdGFyIjoiXC91cGxvYWRcL2ltYWdlc1wvcHJvZmlsZXNcLzEwMl9wcm9maWxlXzE0MzgxNTc2ODkucG5nIn19.Bx76H_ZZpA5qrE0fNakTSi-u8JL5YSY67ISTAqNLT7HvvLbnfhVp3J4abmZfJNu9F-5dWd99i08c07aP4_hJTQ",
                user: {
                    id: "52",
                    username: "yudasukmana",
                    email: "yuda.sukmana.1992@gmail.com",
                    avatar: "https://dev.sociocaster.com/upload/images/profiles/102_profile_1438157689.png"
                }
            }
            localStorage.setItem('auth', JSON.stringify(userdata))
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
                dispatch(fetch())

            }
        }
    }

}

function setup() {



}

function fetch() {

    $.get('/panel/gettoken', function(response) {
        localStorage.setItem('auth', JSON.stringify(response))
        setup()
        return {

            type: 'AUTH_SUCCESS',
            data: response
        }

    }, 'json')

}

module.exports = {
    init: init
}