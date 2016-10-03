function auth(state = {
    isLoggedIn: false,
    jwt: '',
    user: {}
}, action) {

    console.log(action.type)
    switch (action.type) {
        case 'AUTH_SUCCESS':
            return Object.assign({}, state, {
                isLoggedIn: true,
                jwt: action.data.jwt,
                user: action.data.user
            })
        default:
            return state

    }


}

module.exports = auth