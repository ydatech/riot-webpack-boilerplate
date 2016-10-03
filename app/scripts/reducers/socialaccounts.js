function socialaccounts(state = {}, action){

    switch(action.type){
        case 'SOCIALACCOUNTS_LOADED':
            return Object.assign({},state,{data:action.data})
        default:
            return state


    }

    
}