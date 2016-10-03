const numeral = require('numeral')
const moment = require('moment')

function formatNumber(number) {
    return numeral(number).format('0a')
}

function formatDate(date, format) {
    return moment(date, format).fromNow()
}

function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function convertToHTML(content) {

    return content.replace(/(?:\r\n|\r|\n)/g, '<br/>')
}

module.exports = {
    formatNumber: formatNumber,
    formatDate: formatDate,
    capitalizeFirstLetter: capitalizeFirstLetter,
    convertToHTML: convertToHTML
}