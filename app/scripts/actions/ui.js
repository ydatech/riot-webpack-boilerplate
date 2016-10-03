const $ = require("jquery")

function activateSidebar(name) {

    return {
        type: 'SIDEBAR_ACTIVATED',
        data: name

    }

}

function detectScreen() {
    $("#main").css("min-height", screen.height + "px")
}

module.exports = {

    activateSidebar: activateSidebar,
    detectScreen: detectScreen
}