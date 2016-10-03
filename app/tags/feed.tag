<app-feed>
    <div class="feed-detail">
        <div class="row">
            <div class="col-lg-12">
                <div class="main-page-header clearfix">
                    <div class="breadcrumb">
                        <span> <a href="/feed"> Feeds </a> <i if={opts.feedId} class="fa fa-angle-right"></i> <a if={opts.feedId} href="/feed/{opts.feedId}">{state.feed.activeItem.site_title}</a> </span>
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
                            <a href="{state.feed.activeItem.site_url}" target="_blank"> <img if={state.feed.activeItem.favicon} class="feed-favicon" src="{state.feed.activeItem.favicon}" width="16px">{state.feed.activeItem.site_title}</a>
                        </h3>
                        <span if={opts.feedId} class="pull-right"><a href="#" onclick={deleteFeed} class="btn borderless-btn delete-feed"><i class="fa fa-trash"></i> Delete this feed</a></span>

                    </div>
                    <!-- /page-header -->
                    <div class="feed-list">
                        <ul>
                            <li each={value, key in state.feed.activeItem.content} class="clearfix">
                                <div class="feed-content pull-left">
                                    <h3>
                                        <a href="{value.link}" target="_blank">{value.title}</a>
                                    </h3>
                                    <p class="publish-time"> Published {formater.formatDate(value.timestamp,'X')}</p>
                                    <p>{value.description}</p>

                                </div>
                                <a href="#" onclick={shareThis} class="btn pull-right borderless-btn"><i class="fa fa-share"></i> Share</a>
                            </li>

                        </ul>
                    </div>
                    <!-- /feed-list -->
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

            if (this.state.feed.isLoadingContent) {

                uiloader.blockEl()
            } else {

                uiloader.unblockEl()
            }
            this.update()
        }.bind(this))
        this.on('mount', function() {
            this.state = store.getState()
            this.formater = formater

            let data = {}

            data.id = this.opts.feedId



            store.dispatch(actions.feed.loadContent(data))

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
    </script>

</app-feed>