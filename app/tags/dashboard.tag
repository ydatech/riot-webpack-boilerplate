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
			<div class="row" style="display:none;">
				<div class="col-lg-12">
					<div class="overview-big-box">
						<div class="row">
							<div class="col-lg-4">
								<div class="overview-chart overview-boxes">
									chart goes here
								</div>
								<!-- /overview-chart -->
							</div>
							<div class="col-lg-4">
								<div class="overview-cbox overview-boxes">
									<p class="cur-cbox">Currently running: <span>Funny Memes</span></p>
									<p class="cbox-count">700 <span>ContentBox items</span></p>
									<a href="#" class="btn btn-default">Manage</a>
								</div>
								<!-- /overview-cbox -->
							</div>
							<div class="col-lg-4">
								<div class="purchase-content overview-boxes">
									<a href="#">
										<i class="fa fa-shopping-cart"></i>
										<span>Purchase Content</span>
									</a>
								</div>
								<!-- /purchase-content -->
							</div>
						</div>
					</div>
					<!-- /overview-box -->
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div id="recommended-block" class="recommended-for-you content-block">
						<div class="page-header clearfix">
							<h3 class="pull-left">Recommended for You</h3>
							<a href="topcontent" class="see-detail pull-right">See all <i class="fa fa-angle-right"></i></a>
						</div>
						<!-- /page-header -->
						<div class="recommended-content">
							<div class="dashboard-item dashboard-content">
								<div class="row grid">
									<div each={value, key in state.dashboard.recommendedItems} class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
										<div class="grid-thumb">
											<div class="thumb">
												<a href="{value.link}" class="linkto-post">
													<img src="{value.picture}" class="img-responsive">
												</a>
											</div>
											<div class="carousel-caption">
												<div class="source" data-toggle="tooltip" data-placement="bottom" title="{value.page_name}">
													<span>Source: </span>
													<a target="_blank" href="https://facebook.com/{value.page_id}">{value.page_name}</a>
												</div>

												<div class="content-stats">
													<span><i class="fa fa-thumbs-up"></i> {formatNumber(value.likes_count)}</span>
													<span><i class="fa fa-comment"></i> {formatNumber(value.comments_count)}</span>
												</div>

											</div>
											<div class="thumb-over">
												<a href="#" class="btn" onclick={shareThis} data-toggle="tooltip" data-placement="top" title="Share"><i class="fa fa-share"></i></a>
												<a href="#" onclick={showPreview} data-type="pictures" data-mode="topcontent_picture" class="btn" data-toggle="tooltip" data-placement="top" title="preview"><i class="fa fa-eye"></i></a>
											</div>
										</div>
										<!--/grid-->
									</div>
								</div>

							</div>
							<!-- /recommended-content -->
						</div>
					</div>
				</div>

			</div>
			<div class="row">
				<div class="col-lg-12">
					<div id="latest-template-block" class="content-block">
						<div class="page-header clearfix">
							<h3 class="pull-left">Latest from Templates</h3>
							<a href="template" class="see-detail pull-right">See all <i class="fa fa-angle-right"></i></a>
						</div>
						<!-- /page-header -->
						<div class="latest-templates">
							<div id="latest-from-templates" class="dashboard-item dashboard-template">
								<div class="row grid">
									<div each={value, key in state.dashboard.latesttemplatesItems} class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
										<div class="grid-thumb">
											<a href="#" class="thumb">
												<img src="https://sociocaster.com{value.thumbnail}" class="img-responsive">
											</a>
											<div class="thumb-over">

												<a href="#" onclick={editTemplate} data-type="pictures" data-mode="topcontent_picture" class="btn" data-toggle="tooltip" data-placement="top" title="Edit Template"><i class="fa fa-paint-brush"></i></a>

											</div>
										</div>

									</div>
								</div>
							</div>
						</div>
						<!-- /recommended-content -->
					</div>

				</div>
				<!-- /content-block -->
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div id="latest-feed-block" class="content-block latest-feed">
						<div class="page-header clearfix">
							<h3 class="pull-left">Feeds </h3>
							<span class="pull-right"><a href="feed" class="see-detail">See all <i class="fa fa-angle-right"></i></a></span>
							<!--<div class="dropdown pull-right">
								<button class="btn borderless-btn" id="dLabel" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									All Feeds
									<span class="caret"></span>
									</button>
								<ul class="dropdown-menu" aria-labelledby="dLabel">
									<li><a href="#">All Feeds</a></li>
									<li><a href="#">Some Feeds</a></li>
								</ul>
							</div>-->
						</div>
						<!-- /page-header -->
						<div class="feed-list">
							<ul>
								<li each={value, key in state.dashboard.latestfeedsItems} class="clearfix">
									<div class="feed-content pull-left">
										<h3><a href="{value.link}" target="_blank">{value.title}</a></h3>
										<p class="publish-time"> Published {formater.formatDate(value.timestamp,'X')} by source.com</p>
										<p>{value.description}</p>
									</div>

									<a href="#" class="btn borderless-btn  pull-right" onclick={shareFeed}><i class="fa fa-share"></i>Share</a>

								</li>

							</ul>
						</div>
						<!-- /feed-list -->
					</div>
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

			if (this.state.dashboard.isLoadingRecommended) {

				uiloader.blockEl('div#recommended-block')
			} else {

				uiloader.unblockEl('div#recommended-block')
			}

			if (this.state.dashboard.isLoadingLatestfeeds) {
				uiloader.blockEl('div#latest-feed-block')
			} else {
				uiloader.unblockEl('div#latest-feed-block')
			}

			if (this.state.dashboard.isLoadingLatesttemplates) {
				uiloader.blockEl('div#latest-template-block')
			} else {
				uiloader.unblockEl('div#latest-template-block')
			}
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
			store.dispatch(actions.dashboard.loadRecommended())
			store.dispatch(actions.dashboard.loadLatesttemplates())
			store.dispatch(actions.dashboard.loadLatestfeeds())



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

		editTemplate(e) {
			myPixie.openTemplate({
				enableCORS: true,
				id: e.item.value.id,
				saveUrl: '/template/save',
				url: e.target,
				image: {
					tid: e.item.value.id,
					type: tmb.attr('data-type'),
					thumb: 'https://sociocaster.com' + e.item.value.thumbnail
				},
				onShare: function(imageData, tmb) {
					console.log(tmb)
					var mycontent = '';
					var pic = imageData;
					var mydescription = '';
					$('.selectGroup').load('/panel/ContentboxgroupList');
					$('.loading-overlay').fadeIn(1000);
					$.post('/template/imagesave', {
						data: imageData,
						tid: tmb.tid,
						type: tmb.type,
						thumb: tmb.thumb
					}, function(response) {
						if (tmb.type == 'draft') {

							var item = response
							item['type'] = 'picture'
							item['message'] = ''
							item['isTemplate'] = 1
							item['template_id'] = tmb.tid

						} else {
							mycontent = response.picture;
							var host = '<?php echo  Yii::app()->request->hostInfo;?>'

							var item = {
								type: 'picture',
								picture: host + mycontent,
								message: ''
							}
						}

						$('.loading-overlay').fadeOut(1000);
						RiotControl.trigger('smart_poster_init', {
							mode: 'new',
							post: item
						})

					}, 'json');




				},
				onCloseDraft: function(imageData) {

					tmb.attr('src', imageData);

				},

			});

		}
	</script>
</app-dashboard>