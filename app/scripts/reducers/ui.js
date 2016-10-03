function ui(state = {}, action){

    switch(action.type){
        case 'SIDEBAR_ACTIVATED':
            return Object.assign({},state,{sidebarActive:action.data})
        default:
            return state


    }

    
}

module.exports = ui