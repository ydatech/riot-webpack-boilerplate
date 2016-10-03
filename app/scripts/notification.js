const $ = require('jquery')
const noty = require('noty')

let n = null

function notification(message, type) {


    n = noty({
        text: message,
        type: type,
        layout: 'topCenter',
        animation: {
            //open: 'animated fadeIn', // Animate.css class names
            //close: 'animated fadeOut', // Animate.css class names
            open: {
                height: 'toggle'
            }, // jQuery animate function property object
            close: {
                height: 'toggle'
            }, // jQuery animate function property object
            easing: 'swing', // unavailable - no need
            speed: 500 // unavailable - no need
        },
        timeout: 10000

    })

    return n

}

module.exports = notification