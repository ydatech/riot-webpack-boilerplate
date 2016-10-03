<app-twitter-results>
	<div class="result-detail result-twitter">
		<div class="row">
			<div class="col-lg-12">
				<div class="main-page-header clearfix">
					<div class="breadcrumb">
						<a href="/keyword">Search By Keyword </a>
						<i class="fa fa-angle-right"></i>
						<span><i class="fa fa-twitter"></i> Twitter Search Results</span>
					</div>
				</div>
				<!-- /page-header -->
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
				<div class="content-block search-result">
					<div class="page-header clearfix">
						<h3>Search Results for "{state.search.keyword}" </h3>
					</div>
					<!-- /page-header -->
					<div class="result-list">
						<div if={state.search.results.twitter.statuses.length<1} class="no-result">
							<i class="fa fa-frown-o"></i>
							<p>There is no result to show at this moment. Please try again next time.</p>
						</div>
						<ul class="media-list">
							<li each={ value, key in state.search.results.twitter.statuses} class="media">
								<div class="media-left">
									<a href="{value.user.url}">
										<img class="media-object" src="{value.user.profile_image_url_https}" alt="{value.user.screen_name}">
									</a>
								</div>
								<div class="media-body">
									<h4 class="media-heading">{value.user.name}</h4>
									<p>{value.text}</p>
									<div class="this-stats-wrap">
										<span class="stats stats-retweet"> <i class="fa fa-retweet"></i> {formatNumber(value.retweet_count)}</span>
										<span class="stats stats-love"><i class="fa fa-heart"></i> {formatNumber(value.favorite_count)}</span>
										<span class="stats stats-time"><i class="fa fa-clock-o"></i> {formatDate(value.created_at)}</span>
									</div>
								</div>
								<div class="media-right"><a href="#" onclick={shareThis} class="btn borderless-btn borderless-btn pull-right">Share This</a></div>
							</li>
						</ul>

					</div>
					<div if={typeof state.search.results.twitter.search_metadata.next_results !=='undefined' } class="more-button text-center">
						<a onclick={loadMore} data-provider="twitter" class="btn borderless-btn borderless-btn" disabled={state.search.isLoadingMore}> <i class="fa fa-icon {state.search.isLoadingMore ? 'ajax-loading-icon fa-spin fa-spinner':'fa-refresh'}"></i> {state.search.isLoadingMore?'Loading More ..':'Load More ..'}</a>
					</div>
					<!-- /feed-list -->
				</div>
			</div>
		</div>
		<script>
			const $ = require('jquery')
			const store = this.opts.store
			const actions = require('../scripts/actions/index.js')
			const notification = require('../scripts/notification.js')
			const uiloader = require('../scripts/uiloader.js')
			const moment = require('moment')
			const numeral = require('numeral')
			const observables = require('../scripts/observables/index.js')

			store.subscribe(function() {
				this.state = store.getState()

				this.update()

				if (!this.state.search.isLoading) {
					uiloader.unblockEl()
				}
			}.bind(this))

			this.on('updated', function() {
				this.resetHeight()
			})

			this.on('mount', function() {
				uiloader.blockEl()
				this.resetHeight()
				this.state = store.getState()
				$(this.root).addClass('push250 detail-page')

			})

			loadMore(e) {

				store.dispatch(actions.search.loadMore(e.currentTarget.dataset.provider))
			}
			resetHeight() {
				let sameHeight = $(this.root).outerHeight();
				$('div#slide-block').css('height', sameHeight + 'px');
			}
			formatNumber(number) {
				return numeral(number).format('0a')
			}
			formatDate(date) {
				return moment(date, 'ddd MMM DD HH:mm:ss ZZ YYYY').fromNow()
			}
			shareThis(e) {

				let data = {}
				data.source = 'twitter'

				data.item = e.item

				observables.preview.trigger('open_share_dialog', data)
			}
		</script>
	</div>
</app-twitter-results>