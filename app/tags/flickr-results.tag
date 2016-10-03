<app-flickr-results>
    <div class="result-detail result-flickr">
        <div class="row">
            <div class="col-lg-12">
                <div class="main-page-header clearfix">
                    <div class="breadcrumb">
                        <a href="/keyword">Search By Keyword </a>
                        <i class="fa fa-angle-right"></i>
                        <span><i class="fa fa-flickr"></i> Flickr Search Results</span>
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
                        <div if={state.search.results.flickr.photos.length<1} class="no-result">
                            <i class="fa fa-frown-o"></i>
                            <p>There is no result to show at this moment. Please try again next time.</p>
                        </div>
                        <ul class="media-list">
                            <li each={ value, key in state.search.results.flickr.photos} class="media">
                                <div class="media-left">
                                    <a class="fl-over" href="#" onclick={showPreview} data-toggle="tooltip" data-placement="top" title="Click here to preview photo..">
                                        <span class="playme"><i class="fa fa-picture-o"></i> </span>
                                        <img class="media-object" src="{value.url_med}" alt="{value.title}">
                                    </a>
                                </div>
                                <div class="media-body">
                                    <p>{value.title}</p>
                                    <!--<h4 class="media-heading">{value.description}</h4>
                                    <div class="this-stats-wrap">
                                        <span class="stats stats-one"> <i class="fa fa-eye"></i> {formatNumber(value.statistics.viewCount)}</span>
                                        <span class="stats stats-one"> <i class="fa fa-comment-o"></i> {formatNumber(value.statistics.commentCount)}</span>
                                        <span class="stats stats-two"><i class="fa fa-thumbs-o-up"></i> {formatNumber(value.statistics.likeCount)}</span>
                                        <span class="stats stats-two"><i class="fa fa-thumbs-o-down"></i> {formatNumber(value.statistics.dislikeCount)}</span>
                                        <span class="stats stats-three"><i class="fa fa-clock-o"></i> {formatDate(value.published_at)}</span>
                                    </div>
                                    -->
                                </div>
                                <div class="media-right"><a href="#" onclick={shareThis} class="btn borderless-btn borderless-btn pull-right">Share This</a></div>
                            </li>
                        </ul>

                    </div>
                    <div if={state.search.results.flickr.search_metadata.current_page < state.search.results.flickr.search_metadata.total_pages } class="more-button text-center">
                        <a onclick={loadMore} data-provider="flickr" class="btn borderless-btn borderless-btn" disabled={state.search.isLoadingMore}> <i class="fa fa-icon {state.search.isLoadingMore ? 'ajax-loading-icon fa-spin fa-spinner':'fa-refresh'}"></i> {state.search.isLoadingMore?'Loading More ..':'Load More ..'}</a>
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
                $('[data-toggle="tooltip"]').tooltip()
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
                return moment(date, 'YYYY-MM-DDThh:mm:ss.sZ').fromNow()
            }
            showPreview(e) {


                observables.preview.trigger('show_media_preview', {
                    item: e.item,
                    mode: 'flickr',
                    source: 'keyword',
                    length: this.state.search.results.flickr.photos.length
                })

            }
            shareThis(e) {

                let data = {}
                data.source = 'flickr'

                data.item = e.item

                observables.preview.trigger('open_share_dialog', data)
            }
        </script>
    </div>
</app-flickr-results>