const $ = require('jquery')
const scApi = require('../api.js')
const notification = require('../notification.js')
const riot = require('riot')

let xhrCreate
let xhrDelete
let xhrUpdate
let xhr


function initBoxList() {

    return function(dispatch, getState) {
        if (!getState().contentbox.isCached) {
            dispatch({
                type: 'BOX_LOADING',
                isLoadingBox: true
            })

            $.get(`${scApi.base_url}/contentboxes`, function(response) {

                if (response.success) {

                    dispatch({

                        type: 'BOX_LOADED',
                        isLoadingBox: false,
                        items: response.data.items,
                        isCached: true
                    })


                }

            })


        }
    }
}

function loadContent(data) {
    return function(dispatch, getState) {

        dispatch({
            type: 'CB_RESET_CONTENT'
        })
        let params = {
            expand: 'content',
        }

        if (xhr && xhr.readyState != 4) {
            xhr.abort();
        }

        dispatch({
            type: 'CB_CONTENT_LOADING',
            isLoadingContent: true
        })
        let url = `${scApi.base_url}/contentboxes/${data.id}`
        if (typeof data.id == 'undefined') {
            url = `${scApi.base_url}/contentboxes/content`
        }

        xhr = $.get(url, params, function(response) {

            if (response.success) {


                dispatch({
                    type: 'CB_CONTENT_LOADED',
                    isLoadingContent: false,
                    activeItem: response.data

                })

            } else {
                dispatch({
                    type: 'CB_CONTENT_LOADING',
                    isLoadingContent: false
                })
            }
        })
    }

}

function createNewBox(name) {
    return function(dispatch, getState) {

        let params = {
            name: name
        }
        if (xhrCreate && xhrCreate.readyState != 4) {
            xhrCreate.abort();
        }

        dispatch({
            type: 'BOX_CREATING',
            isCreatingBox: true
        })
        xhrCreate = $.post(`${scApi.base_url}/contentboxes`, params, function(response) {

            if (response.success) {
                dispatch({
                    type: 'BOX_CREATED',
                    item: response.data,
                    isCreatingBox: false

                })

                notification(`<b>${name}</b> has been added to your Content Box list`, 'success')
                riot.route(`contentbox/${response.data.id}`)
            } else {
                dispatch({
                    type: 'BOX_CREATING',
                    isCreatingFeed: false
                })
                if (typeof response.data.message !== 'undefined')
                    notification(response.data.message, 'error')
                else if (typeof response.data[0] !== 'undefined')
                    notification(response.data[0].message, 'error')
                else
                    notification('Something went wrong, please try again!', 'error')

            }
        })
    }
}

function updateBox(data) {

    return function(dispatch, getState) {
        let params = {
            name: data.name.trim()
        }
        if (xhrUpdate && xhrUpdate.readyState != 4) {
            xhrUpdate.abort();
        }
        notification('<b>Please Wait!</b> Updating the Content Box name...', 'success')
        xhrUpdate = $.ajax({

            url: `${scApi.base_url}/contentboxes/${getState().contentbox.activeItem.id}`,
            method: 'PATCH',
            data: params,
            success: function(response) {
                if (response.success) {
                    notification(`<b>${getState().contentbox.activeItem.name}</b> has been renamed to <b>${data.name} </b> `, 'success')
                    let index = getState().contentbox.items.findIndex(function(item) {
                        return item.id == getState().contentbox.activeItem.id
                    })

                    dispatch({
                        type: 'BOX_UPDATED',
                        data: response.data,
                        index: index

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

function deleteBox() {

    return function(dispatch, getState) {
        if (xhrDelete && xhrDelete.readyState != 4) {
            xhrDelete.abort();
        }
        notification('<b>Please Wait!</b> Deleting the Content Box..', 'success')
        xhrDelete = $.ajax({

            url: `${scApi.base_url}/contentboxes/${getState().contentbox.activeItem.id}`,
            method: 'DELETE',
            statusCode: {
                204: function() {
                    //alert( "success" );
                    notification(`<b>${getState().contentbox.activeItem.name}</b> has been deleted!`, 'success')
                    let index = getState().contentbox.items.findIndex(function(item) {
                        return item.id == getState().contentbox.activeItem.id
                    })
                    dispatch({
                        type: 'BOX_DELETED',
                        index: index

                    })

                    riot.route('contentbox')
                }
            }
        })

    }

}

function updateContent(data) {



    return function(dispatch, getState) {
        let params = {}

        if (data.mode == 'description') {

            params['description'] = data.description
        } else if (data.mode == 'content') {
            params['content'] = data.content
        }
        if (xhrUpdate && xhrUpdate.readyState != 4) {
            xhrUpdate.abort();
        }
        notification('<b>Please Wait!</b> Updating the content...', 'success')
        xhrUpdate = $.ajax({

            url: `${scApi.base_url}/contentboxes/content/${data.id}`,
            method: 'PATCH',
            data: params,
            success: function(response) {
                if (response.success) {
                    notification('The content has been updated!', 'success')

                    dispatch({
                        type: 'CB_UPDATED',
                        data: response.data,
                        index: data.index

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

function deleteContent(data) {

    return function(dispatch, getState) {
        if (xhrDelete && xhrDelete.readyState != 4) {
            xhrDelete.abort();
        }
        notification('<b>Please Wait!</b> Deleting the content..', 'success')
        xhrDelete = $.ajax({

            url: `${scApi.base_url}/contentboxes/content/${data.id}`,
            method: 'DELETE',
            statusCode: {
                204: function() {
                    //alert( "success" );
                    notification('The content has been deleted!', 'success')
                    dispatch({
                        type: 'CB_DELETED',
                        index: data.index

                    })


                }
            }
        })

    }
}

function importContent(data) {

    return function(dispatch, getState) {

        let params = {
            content: JSON.stringify(data)
        }
        if (xhrCreate && xhrCreate.readyState != 4) {
            xhrCreate.abort();
        }

        notification('<b>Please Wait!</b> Importing the content..', 'success')
        xhrCreate = $.post(`${scApi.base_url}/contentboxes/import/${getState().contentbox.activeItem.id}`, params, function(response) {

            if (response.success) {
                dispatch({
                    type: 'CB_IMPORTED',
                    data: response.data,
                    isCreatingBox: false

                })

                notification(`The file content has been imported to this Content Box`, 'success')

            } else {

                if (typeof response.data.message !== 'undefined')
                    notification(response.data.message, 'error')
                else if (typeof response.data[0] !== 'undefined')
                    notification(response.data[0].message, 'error')
                else
                    notification('Something went wrong, please try again!', 'error')

            }
        })
    }
}

function checkAll(check) {


    return {
        type: 'CB_CHECK_ALL',
        checkAll: check
    }


}

function checkItem(data) {

    return {
        type: 'CB_CHECK_ITEM',
        checkItem: data.check,
        index: data.item.key
    }

}

function deleteAllContent() {

    return function(dispatch, getState) {
        if (xhrDelete && xhrDelete.readyState != 4) {
            xhrDelete.abort();
        }





        notification('<b>Please Wait!</b> Deleting all content in this Content Box..', 'success')
        xhrDelete = $.ajax({

            url: `${scApi.base_url}/contentboxes/allcontent/${getState().contentbox.activeItem.id}`,
            method: 'DELETE',
            statusCode: {
                204: function() {
                    //alert( "success" );
                    notification(`Content has been deleted!`, 'success')
                    let index = getState().contentbox.items.findIndex(function(item) {
                        return item.id == getState().contentbox.activeItem.id
                    })
                    dispatch({
                        type: 'CB_ALL_DELETED',

                    })

                }
            }
        })

    }
}

function deleteSelectedContent() {

    return function(dispatch, getState) {
        if (xhrDelete && xhrDelete.readyState != 4) {
            xhrDelete.abort();
        }

        let params = {}

        params.ids = []

        let indexes = []
        getState().contentbox.activeItem.content.forEach(function(element, index, array) {
            if (element.isChecked) {

                params.ids.push(element.id)

                indexes.push(index)
            }


        })

        if (params.ids.length > 0) {
            notification('<b>Please Wait!</b> Deleting selected content in this Content Box..', 'success')
            xhrDelete = $.ajax({

                url: `${scApi.base_url}/contentboxes/selectedcontent/${getState().contentbox.activeItem.id}`,
                method: 'DELETE',
                data: params,
                statusCode: {
                    204: function() {
                        //alert( "success" );
                        notification(`Content has been deleted!`, 'success')
                        let index = getState().contentbox.items.findIndex(function(item) {
                            return item.id == getState().contentbox.activeItem.id
                        })
                        dispatch({
                            type: 'CB_SELECTED_DELETED',
                            indexes: indexes

                        })

                    }
                }
            })
        } else {

            notification('<b> Ups!</b> You have to select at least one content', 'error')
        }
    }
}


module.exports = {

    initBoxList: initBoxList,
    createNewBox: createNewBox,
    loadContent: loadContent,
    updateBox: updateBox,
    deleteBox: deleteBox,
    updateContent: updateContent,
    deleteContent: deleteContent,
    importContent: importContent,
    checkAll: checkAll,
    checkItem: checkItem,
    deleteAllContent: deleteAllContent,
    deleteSelectedContent: deleteSelectedContent
}