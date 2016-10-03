const riot = require('riot')
const reduxStore = require('./store.js')
const actions = require('./actions/index.js')

let contentPage = false
let blockSlide = false



function handler(collection, id, action, source) {
	let queryParams = riot.route.query()
	switch (collection) {
		case 'keyword':
			keyword(id, action, queryParams)
			break;
		case 'topcontent':
			topcontent(id, action, source, queryParams)
			break;
		case 'feed':
			feed(id, action, queryParams)
			break;
		case 'contentbox':
			contentbox(id, action, queryParams)
			break;
		case 'template':
			template(id, action, queryParams)
			break;
		default:
			home()
			break;


	}
}

function mountContent(tag, options) {
	//console.log(contentPage)
	contentPage && contentPage[0].unmount(true)
	return riot.mount('div#main', tag, options)

}

function mountBlockSlide(tag, options) {
	//console.log(blockSlide)
	blockSlide && blockSlide[0].unmount(true)

	return riot.mount('div#slide-block', tag, options)
}


function home() {
	reduxStore.dispatch(actions.ui.activateSidebar(''))
		//console.log(blockSlide)
	blockSlide && blockSlide[0].unmount(true)
	contentPage = mountContent('app-dashboard', {
		_id: 'dashboard',
		action: 'action',
		store: reduxStore
	})
}

function keyword(id, action, queryParams) {
	console.log(queryParams)
	reduxStore.dispatch(actions.ui.activateSidebar('keyword'))

	if ('k' in queryParams) {
		console.log(queryParams.k)
		let keyword = decodeURI(queryParams.k)
		console.log(keyword)
		reduxStore.dispatch(actions.search.searchKeyword(id, keyword))

	}

	blockSlide = mountBlockSlide('app-keyword-block', {
		action: 'keyword',
		store: reduxStore
	})

	if (typeof id !== 'undefined') {
		contentPage = mountContent(`app-${id}-results`, {
			store: reduxStore
		})
	} else {
		contentPage = mountContent(`app-keyword`, {
			store: reduxStore
		})
	}


}

function topcontent(type, category, source, queryParams) {
	reduxStore.dispatch(actions.ui.activateSidebar('topcontent'))
	const ignoreData = ['filter=week', 'filter=month', 'filter=all']

	if (typeof category !== 'undefined' && category.length <= 0) {
		category = 'filter=week'
	}
	if (typeof source !== 'undefined' && source.length <= 0) {
		source = 'filter=week'
	}
	let contentType = ''
	if (typeof type !== 'undefined') {
		contentType = 'type'
		reduxStore.dispatch(actions.topcontent.expandType(type))

	} else {
		reduxStore.dispatch(actions.topcontent.expandType(''))
	}



	if (typeof category !== 'undefined' && ignoreData.indexOf(category) == -1 && category.indexOf('region=') == -1) {
		contentType = 'category'
		reduxStore.dispatch(actions.topcontent.expandCategory(category))

	} else {
		reduxStore.dispatch(actions.topcontent.expandCategory(''))
	}

	if (typeof source !== 'undefined' && ignoreData.indexOf(source) == -1 && source.indexOf('region=') == -1) {
		contentType = 'source'
		reduxStore.dispatch(actions.topcontent.expandSource(source))

	} else {
		reduxStore.dispatch(actions.topcontent.expandSource(''))
	}

	if ('filter' in queryParams) {
		reduxStore.dispatch(actions.topcontent.setFilter(queryParams.filter))
	} else {
		reduxStore.dispatch(actions.topcontent.setFilter('new'))
	}


	if ('region' in queryParams) {
		reduxStore.dispatch(actions.topcontent.setRegion(queryParams.region))
	} else {
		reduxStore.dispatch(actions.topcontent.setRegion(reduxStore.getState().auth.user.country))
	}
	blockSlide = mountBlockSlide('app-topcontent-block', {
		action: 'topcontent',
		store: reduxStore
	})
	let topcontenttag = 'app-topcontent'
	if (contentType) {
		topcontenttag = 'app-topcontent-details'
	}
	if (source == 'new') {
		topcontenttag = "app-topcontent-new-source"
	}
	contentPage = mountContent(topcontenttag, {
		store: reduxStore,
		contentType: contentType,
		type: type,
		category: category,
		source: source

	})

}

function feed(id, action, queryParams) {
	reduxStore.dispatch(actions.ui.activateSidebar('feed'))
	blockSlide = mountBlockSlide('app-feed-block', {
		action: 'feed',
		store: reduxStore
	})

	contentPage = mountContent(`app-feed`, {
		store: reduxStore,
		feedId: id
	})


}

function contentbox(id, action, queryParams) {

	reduxStore.dispatch(actions.ui.activateSidebar('contentbox'))
	blockSlide = mountBlockSlide('app-contentbox-block', {
		action: 'contentbox',
		store: reduxStore
	})

	contentPage = mountContent(`app-contentbox`, {
		store: reduxStore,
		contentboxId: id
	})

}

function template(id, action, queryParams) {

	reduxStore.dispatch(actions.ui.activateSidebar('template'))
	let mountTag = 'app-template'
	if (typeof id !== 'undefined' && id.indexOf('keyword=') == -1) {

		reduxStore.dispatch(actions.template.setType(id))
	} else {
		reduxStore.dispatch(actions.template.setType(''))
		mountTag = 'app-template-search'
	}
	if ('keyword' in queryParams) {
		reduxStore.dispatch(actions.template.setKeyword(queryParams.keyword))
	} else {
		reduxStore.dispatch(actions.template.setKeyword(''))
	}


	blockSlide = mountBlockSlide('app-template-block', {
		action: 'contentbox',
		store: reduxStore,
	})

	contentPage = mountContent(mountTag, {
		store: reduxStore,
		contentboxId: id
	})
}


module.exports = {

	handler: handler

}