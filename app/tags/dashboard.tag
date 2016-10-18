<app-dashboard>
	<div class="dashboard">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<div class="main-page-header clearfix">
						<h3 class="pull-left">Overview</h3>
					</div>
					<!-- /page-header -->
				</div>
			</div>



			<div class="row">
				<div class="col-lg-12">
					<canvas id="canvas" width="800" height="800"></canvas>
				</div>
			</div>
		</div>
	</div>
	<!--/dashboard-->
	<script>
		const $ = require('jquery')
		const store = this.opts.store
		const actions = require('../scripts/actions/index.js')
		const notification = require('../scripts/notification.js')
		const uiloader = require('../scripts/uiloader.js')
		const moment = require('moment')
		const formater = require('../scripts/formater.js')
		const numeral = require('numeral')
		const observables = require('../scripts/observables/index.js')


		store.subscribe(function() {
			this.state = store.getState()

			this.update()


		}.bind(this))

		this.on('updated', function() {
			$('[data-toggle="tooltip"]').tooltip()
		})

		this.on('mount', function() {
			this.formater = formater
				//uiloader.blockEl()
				//$('#recommended-carousel').carousel({
				//   interval: 0
				// });  
				//store.dispatch(actions.dashboard.loadRecommended())
				//store.dispatch(actions.dashboard.loadLatesttemplates())
				//store.dispatch(actions.dashboard.loadLatestfeeds())



		})
		formatNumber(number) {
			return numeral(number).format('0a')
		}
		showPreview(e) {

			observables.preview.trigger('show_media_preview', {
				item: e.item,
				mode: 'topcontent_picture',
				source: 'topcontent_dashboard',
				length: this.state.dashboard.recommendedItems
			})

		}
		shareThis(e) {

			let data = {}
			data.source = 'topcontent_picture'

			data.item = e.item

			observables.preview.trigger('open_share_dialog', data)
		}

		shareFeed(e) {

			let data = {}
			data.source = 'feed'

			data.item = e.item

			observables.preview.trigger('open_share_dialog', data)
		}
	</script>
</app-dashboard>