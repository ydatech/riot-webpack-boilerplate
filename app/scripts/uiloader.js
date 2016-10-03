const $ = require('jquery')
require('block-ui')

const uiloader = {

	blockUI: function() {

		$.blockUI({
			message: '<i class="ajax-loading-icon fa fa-spin fa-cog"></i>',
			timeout: 0,
			overlayCSS: {
				backgroundColor: '#fff',
				opacity: 1,
				cursor: 'wait'
			},
			css: {
				border: 0,
				color: '#1b2024',
				padding: 0,
				backgroundColor: 'transparent'
			}
		});
	},

	unblockUI: function() {


		$.unblockUI();

	},
	blockEl: function(selector) {
		selector = typeof selector !== 'undefined' ? $(selector) : $('#main');
		$(selector).block({
			message: '<i class="ajax-loading-icon fa fa-spin fa-cog"></i>',
			timeout: 0, //disbable auto unblock
			overlayCSS: {
				backgroundColor: '#fff',
				opacity: 0.6,
				cursor: 'wait'
			},
			centerY: 0,
			css: {
				top: '180px',
				border: 0,
				color: '#1b2024',
				padding: 0,
				backgroundColor: 'transparent'
			}
		});
		////console.log(selector);

	},

	unblockEl: function(selector) {
		selector = typeof selector !== 'undefined' ? $(selector) : $('#main');
		$(selector).unblock();
	},


}

module.exports = uiloader