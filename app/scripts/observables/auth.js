const riot = require('riot')


function Auth() {

    riot.observable(this)

    this.on('auth_success', function() {
        console.log('auth_success')

    })
}

const auth = new Auth()

module.exports = auth