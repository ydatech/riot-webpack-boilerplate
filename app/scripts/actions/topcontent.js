const $ = require('jquery')
const scApi = require('../api.js')
const notification = require('../notification.js')
const countries = require('../countries.js')
const riot = require('riot')
let xhr = false
let xhrUpdate = false
let xhrDelete = false
let xhrCreate = false
let indexActiveType = -1
let indexActiveSource = -1
let indexActiveCategory = -1

function initTopContent() {

    return function(dispatch, getState) {
        dispatch({
            type: 'RESET_CONTENT_DATA'
        })

        if (!getState().topcontent.isCached) {

            dispatch(topContentLoading())
            $.get(`${scApi.base_url}/topcontents`, function(response) {

                let originalData = $.extend(true, [], response.data)

                let category = {}
                let source = {}
                indexActiveType = response.data.findIndex(function(item) {
                    return item.type == getState().topcontent.activeType
                })

                if (indexActiveType > -1) {

                    response.data[indexActiveType].expand = true

                    indexActiveCategory = response.data[indexActiveType].categories.findIndex(function(item) {

                        return item.id == getState().topcontent.activeCategory

                    })
                    if (indexActiveCategory > -1) {
                        response.data[indexActiveType].categories[indexActiveCategory].expand = true

                        category = response.data[indexActiveType].categories[indexActiveCategory]
                        if (getState().topcontent.activeType !== 'Videos') {

                            indexActiveSource = response.data[indexActiveType].categories[indexActiveCategory].sources.findIndex(function(item) {

                                return item.id == getState().topcontent.activeSource

                            })

                            if (indexActiveSource > -1) {
                                source = response.data[indexActiveType].categories[indexActiveCategory].sources[indexActiveSource]

                            }
                        }

                    }

                }




                let activeData = {
                    category: category,
                    source: source
                }
                if (response.success) {
                    dispatch(topContentLoaded(response.data, originalData, activeData))
                }
            }, 'json')

        } else {
            let copyOriginal = $.extend(true, [], getState().topcontent.originalItems)
            let categoryEditable = false
            let category = {}
            let source = {}
            indexActiveType = copyOriginal.findIndex(function(item) {
                return item.type == getState().topcontent.activeType
            })

            if (indexActiveType > -1) {


                copyOriginal[indexActiveType].expand = true


                indexActiveCategory = copyOriginal[indexActiveType].categories.findIndex(function(item) {
                    return item.id == getState().topcontent.activeCategory
                })

                if (indexActiveCategory > -1) {
                    copyOriginal[indexActiveType].categories[indexActiveCategory].expand = true
                    category = copyOriginal[indexActiveType].categories[indexActiveCategory]
                    if (getState().topcontent.activeType !== 'Videos') {
                        indexActiveSource = copyOriginal[indexActiveType].categories[indexActiveCategory].sources.findIndex(function(item) {

                            return item.id == getState().topcontent.activeSource

                        })

                        if (indexActiveSource > -1) {
                            source = copyOriginal[indexActiveType].categories[indexActiveCategory].sources[indexActiveSource]

                        }
                    }
                }

            }

            let activeData = {
                category: category,
                source: source
            }
            dispatch(topContentLoaded(copyOriginal, getState().topcontent.originalItems, activeData))


        }

    }

}

function topContentLoading() {

    return {

        type: 'TOPCONTENT_LOADING',
        isLoadingTopContent: true
    }


}

function topContentLoaded(data, originalData, activeData) {

    return {

        type: 'TOPCONTENT_LOADED',
        isLoadingTopContent: false,
        isCached: true,
        data: data,
        originalData: originalData,
        activeData: activeData
    }

}

function expandType(type) {

    return function(dispatch, getState) {




        dispatch({

            type: 'EXPAND_TYPE',
            data: type

        })
    }


}

function expandCategory(category) {

    return {

        type: 'EXPAND_CATEGORY',
        data: category

    }
}

function expandSource(source) {

    return {

        type: 'EXPAND_SOURCE',
        data: source

    }
}

function createNewCategory(data) {
    return function(dispatch, getState) {

        let params = {
            category_name: "New Folder",
            category_type: data.typevalue.categories[0].category_type
        }

        if (xhrCreate && xhrCreate.readyState != 4) {
            xhrCreate.abort();
        }
        xhrCreate = $.post(`${scApi.base_url}/topcontents/category`, params, function(response) {

            if (response.success) {
                notification('New Folder has been created', 'success')
                dispatch({
                    type: 'NEWCATEGORY_CREATED',
                    data: response.data,
                    indexActiveType: data.typekey


                })
            } else {

                if (typeof response.data.message !== 'undefined')
                    notification(response.data.message, 'error')
                else
                    notification('Something went wrong, please try again!', 'error')

            }

        })

    }
}

function updateCategory(data) {

    return function(dispatch, getState) {
        let params = {
            category_name: data.new_category_name.trim()
        }
        if (xhrUpdate && xhrUpdate.readyState != 4) {
            xhrUpdate.abort();
        }
        notification('<b>Please Wait!</b> Updating the folder name...', 'success')
        xhrUpdate = $.ajax({

            url: `${scApi.base_url}/topcontents/category/${getState().topcontent.category.id}`,
            method: 'PATCH',
            data: params,
            success: function(response) {
                if (response.success) {
                    notification(`<b>${getState().topcontent.category.category_name}</b> has been renamed to <b>${data.new_category_name} </b> `, 'success')
                    dispatch({
                        type: 'CATEGORY_UPDATED',
                        data: response.data,
                        indexActiveType: indexActiveType,
                        indexActiveCategory: indexActiveCategory

                    })
                } else {

                    if (typeof response.data.message !== 'undefined')
                        notification(response.data.message, 'error')
                    else
                        notification('Something went wrong, please try again!', 'error')
                }


            }
        })



    }
}


function loadContent(data) {

    return function(dispatch, getState) {


        let params = {
            expand: 'source',
            filter: getState().topcontent.filter
        }
        if (getState().topcontent.region) {
            params['region'] = getState().topcontent.region
        }
        if (xhr && xhr.readyState != 4) {
            xhr.abort();
        }

        dispatch({
            type: 'CONTENT_LOADING',
            isLoadingContent: true
        })
        let url = `${scApi.base_url}/topcontents/content`

        if (data.contentType) {
            url = `${scApi.base_url}/topcontents/${data.contentType}/content/${data.id}`
        }
        xhr = $.get(url, params, function(response, textStatus, jqXhr) {
            //console.log(response)
            //console.log(jqXhr.getResponseHeader('X-FB-Page-After'))
            if (jqXhr.getResponseHeader('X-FB-Page-After')) {
                dispatch({

                    type: 'SET_FBAFTER',
                    fbafter: jqXhr.getResponseHeader('X-FB-Page-After')
                })
            } else {

                dispatch({

                    type: 'SET_FBAFTER',
                    fbafter: ''
                })


            }

            dispatch({

                type: "CONTENT_LOADED",
                data: response.data,
                isLoadingContent: false
            })
        })

    }


}

function loadMoreContent(data) {

    return function(dispatch, getState) {
        let params = {}

        if (getState().topcontent.fbafter) {
            params['fbafter'] = getState().topcontent.fbafter
        }
        if (getState().topcontent.region) {
            params['region'] = getState().topcontent.region
        }
        if (getState().topcontent.contentData._meta.nextPageToken) {
            params['nextPageToken'] = getState().topcontent.contentData._meta.nextPageToken
        }
        if (xhr && xhr.readyState != 4) {
            xhr.abort();
        }

        dispatch({
            type: 'MORECONTENT_LOADING',
            isLoadingMoreContent: true
        })
        let url = ''

        if (getState().topcontent.activeType == 'Videos') {
            url = `${scApi.base_url}/topcontents/${data.contentType}/content/${data.id}`
        } else {
            url = (getState().topcontent.contentData._links.next) ? getState().topcontent.contentData._links.next.href : `${scApi.base_url}/topcontents/${data.contentType}/content/${data.id}?expand=source`
        }
        xhr = $.get(url, params, function(response, textStatus, jqXhr) {
            //console.log(response)
            if (jqXhr.getResponseHeader('X-FB-Page-After')) {
                dispatch({

                    type: 'SET_FBAFTER',
                    fbafter: jqXhr.getResponseHeader('X-FB-Page-After')
                })
            } else {
                dispatch({

                    type: 'SET_FBAFTER',
                    fbafter: ''
                })


            }
            dispatch({

                type: "MORECONTENT_LOADED",
                data: response.data,
                isLoadingMoreContent: false
            })
        })

    }


}

function setFilter(filter) {

    return {
        type: 'SET_FILTER',
        filter: filter
    }
}

function setRegion(region) {
    return function(dispatch, getState) {
        dispatch({
            type: 'SET_REGION',
            region: region
        })
        if (getState().topcontent.activeType == 'Videos') {

            let activeCountry = {}

            let indexActiveCountry = countries.findIndex(function(item) {

                return item.code == getState().topcontent.region
            })
            let countryData = {
                type: 'INIT_COUNTRIES',
                countries: countries,

            }

            if (indexActiveCountry > -1) {
                activeCountry = countries[indexActiveCountry]
            }
            countryData['activeCountry'] = activeCountry
            dispatch(countryData)
        }
    }

}

function editingCategory(data) {
    return {
        type: 'EDITING_CATEGORY',
        isEditingCategory: data
    }
}

function deleteTopContent(type) {
    return function(dispatch, getState) {

        if (xhrDelete && xhrDelete.readyState != 4) {
            xhrDelete.abort();
        }

        let url = `${scApi.base_url}/topcontents/category/${getState().topcontent.activeCategory}`
        let name = getState().topcontent.category.category_name
        let actiontype = 'CATEGORY_DELETED'
        let routeto = `topcontent/${getState().topcontent.activeType}`
        if (type == 'source') {
            url = `${scApi.base_url}/topcontents/source/${getState().topcontent.activeSource}`
            actiontype = 'SOURCE_DELETED'
            name = getState().topcontent.source.page_name
            routeto = `topcontent/${getState().topcontent.activeType}/${getState().topcontent.activeCategory}`

        }
        xhrDelete = $.ajax({

            url: url,
            method: 'DELETE',
            success: function(response) {
                if (response.success) {


                    notification(`<b>${name}</b> has been deleted </b> `, 'success')


                    riot.route(routeto)

                    dispatch({
                        type: actiontype,
                        indexActiveSource: indexActiveSource,
                        indexActiveCategory: indexActiveCategory,
                        indexActiveType: indexActiveType

                    })




                } else {

                    if (typeof response.data.message !== 'undefined')
                        notification(response.data.message, 'error')
                    else
                        notification('Something went wrong, please try again!', 'error')
                }


            }
        })



    }

}

function findSource(keyword, mode) {

    return function(dispatch, getState) {

        let params = {
            keyword: keyword
        }
        if (getState().topcontent.contentData.paging && getState().topcontent.contentData.paging.cursors.after) {
            params['fbafter'] = getState().topcontent.contentData.paging.cursors.after
        }
        if (xhr && xhr.readyState != 4) {
            xhr.abort();
        }
        let loading = {
            type: 'SOURCE_LOADING',
            isLoadingContent: true
        }
        if (mode == 'more') {
            loading = {
                type: 'MORESOURCE_LOADING',
                isLoadingMoreContent: true
            }
        }
        dispatch(loading)
        let url = `${scApi.base_url}/topcontents/findsource`


        xhr = $.get(url, params, function(response, textStatus, jqXhr) {
            //console.log(response)
            //console.log(jqXhr.getResponseHeader('X-FB-Page-After'))
            let loaded = {

                type: "SOURCE_LOADED",
                data: response.data,
                isLoadingContent: false
            }
            if (mode == 'more') {
                loaded = {
                    type: 'MORESOURCE_LOADED',
                    data: response.data,
                    isLoadingMoreContent: false
                }
            }
            dispatch(loaded)
        })

    }
}

function createNewSource(data) {
    return function(dispatch, getState) {

        let params = {
            page_id: data.value.id,
            page_name: data.value.name,
            type: getState().topcontent.category.category_type,
            category: getState().topcontent.category.id,

        }

        if (xhrCreate && xhrCreate.readyState != 4) {
            xhrCreate.abort();
        }
        dispatch({
            type: 'NEWSOURCE_CREATING',
            index: data.key
        })
        xhrCreate = $.post(`${scApi.base_url}/topcontents/source`, params, function(response) {

            if (response.success) {
                notification(`${data.value.name} has been added`, 'success')
                dispatch({
                    type: 'NEWSOURCE_CREATED',
                    data: response.data,
                    indexActiveType: indexActiveType,
                    indexActiveCategory: indexActiveCategory,
                    index: data.key


                })
            } else {

                if (typeof response.data.message !== 'undefined')
                    notification(response.data.message, 'error')
                else
                    notification('Something went wrong, please try again!', 'error')

            }

        })

    }
}


module.exports = {

    initTopContent: initTopContent,
    expandType: expandType,
    expandCategory: expandCategory,
    expandSource: expandSource,
    createNewCategory: createNewCategory,
    updateCategory: updateCategory,
    loadContent: loadContent,
    loadMoreContent: loadMoreContent,
    setFilter: setFilter,
    editingCategory: editingCategory,
    deleteTopContent: deleteTopContent,
    setRegion: setRegion,
    findSource: findSource,
    createNewSource: createNewSource
}