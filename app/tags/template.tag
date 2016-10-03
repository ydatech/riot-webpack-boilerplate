<app-template>
    <div class="template-detail">
        <div class="row">
            <div class="col-lg-12">
                <div class="main-page-header clearfix">
                    <div class="breadcrumb">
                        <span> <a href="/template"> Templates </a> <i if={state.template.activeType} class="fa fa-angle-right"></i> <a if={state.template.activeType} href="/template/{state.template.activeType}">{formater.capitalizeFirstLetter(state.template.activeType)}</a> </span>
                    </div>
                </div>
                <!-- /page-header -->
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div id="latest-feed-block" class="content-block">
                    <div class="page-header clearfix">
                        <h3 class="pull-left">
                            { formater.capitalizeFirstLetter(state.template.activeType)} Templates
                        </h3>

                    </div>
                    <!-- /page-header -->
                    <div class="template-list">
                        <div class="container-fluid">
                            <div class="row grid">
                                <div each={value, key in state.template.data.items} class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
                                    <div class="grid-thumb">
                                        <a href="#" class="thumb">
                                            <img src="https://sociocaster.com{value.thumbnail}" class="img-responsive">
                                        </a>
                                        <div class="thumb-over">
                                            <a href="#" onclick={editTemplate} data-type="pictures" data-mode="topcontent_picture" class="btn" data-toggle="tooltip"
                                                data-placement="top" title="Edit Template"><i class="fa fa-paint-brush"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /feed-list -->

                    <div if={state.template.data._meta.currentPage < state.template.data._meta.pageCount} class="more-button text-center">
                        <a onclick={loadMore} class="btn borderless-btn borderless-btn" disabled={state.template.isLoadingMoreItems}> <i class="fa fa-icon {state.template.isLoadingMoreItems ? 'ajax-loading-icon fa-spin fa-spinner':'fa-refresh'}"></i>                            {state.topcontent.isLoadingMoreContent?'Loading More ..':'Load More ..'}</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        const $ = require('jquery')
        const store = this.opts.store
        const actions = require('../scripts/actions/index.js')
        const notification = require('../scripts/notification.js')
        const formater = require('../scripts/formater.js')
        const uiloader = require('../scripts/uiloader.js')
        const observables = require('../scripts/observables/index.js')


        store.subscribe(function() {
            this.state = store.getState()

            if (this.state.template.isLoadingItems) {

                uiloader.blockEl()
            } else {

                uiloader.unblockEl()
            }
            this.update()
        }.bind(this))
        this.on('mount', function() {
            this.state = store.getState()
            this.formater = formater


            store.dispatch(actions.template.loadItems())

            $(this.root).addClass('push250 detail-page')
            let sameHeight = $(this.root).outerHeight();
            $('div#slide-block').css('height', sameHeight + 'px')

            // this.trigger('init_masonry')

        })

        deleteFeed(e) {

            if (confirm('Are you sure want to delete this feed?')) {
                store.dispatch(actions.feed.deleteFeed())
            }

        }
        shareThis(e) {

            let data = {}
            data.source = 'feed'

            data.item = e.item

            observables.preview.trigger('open_share_dialog', data)
        }

        editTemplate(e) {


        }

        loadMore(e) {

            store.dispatch(actions.template.loadMoreItems())
        }
    </script>
</app-template>