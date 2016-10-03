<app-topcontent>

    <div class="topcontent-main">
        <div class="row">
            <div class="col-lg-12">
                <div class="main-page-header clearfix">
                    <span class="top-path pull-left">Top Content</span>
                </div>
                <!-- /page-header -->
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="recommended-for-you content-block">
                    <div class="page-header clearfix">
                        <h3 class="pull-left">Pictures</h3>
                        <a href="topcontent/Pictures" class="see-detail pull-right">See all <i class="fa fa-angle-right"></i></a>
                    </div>
                    <!-- /page-header -->
                    <div class="recommended-content">
                        <div class="topcontent-landing topcontent-picture">
                            <div class="container-fluid">
                                <div class="row">
                                    <div each={value, key in state.topcontent.contentData.pictures} class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
                                        <div class="grid-thumb">
                                            <div class="thumb">
                                                <img src="{value.picture}" class="img-responsive">
                                            </div>
                                            <div class="topcontent-caption clearfix">
                                                <a href="{value.link}" target="_blank" class="linkto-post">
                                                    <div class="source" data-toggle="tooltip" data-placement="bottom" title="{value.page_name}">
                                                        <span> Source: <a target="_blank" href="https://facebook.com/{value.page_id}" >{value.page_name}</a></span>
                                                    </div>
                                                    <div class="content-stats">
                                                        <span class="stats stats-like"><i class="fa fa-thumbs-up"></i> {formater.formatNumber(value.likes_count)}</span>
                                                        <span class="stats stats-comment"><i class="fa fa-comment"></i> {formater.formatNumber(value.comments_count)}</span>
                                                        <span class="stats stats-time"><i class="fa fa-clock-o"></i> {formater.formatDate(value.created_time_str)}</span>
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="thumb-over">
                                                <a href="#" class="btn" onclick={shareThis} data-type="photo" data-toggle="tooltip" data-placement="top" title="Share"><i class="fa fa-share"></i></a>
                                                <a href="#" onclick={showPreview} data-type="pictures" data-mode="topcontent_picture" class="btn" data-toggle="tooltip" data-placement="top" title="preview"><i class="fa fa-eye"></i></a>
                                            </div>
                                        </div>
                                        <!-- /topcontent-caption -->
                                    </div>
                                    <!-- /grid-thumb -->
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
                <div class="recommended-for-you content-block">
                    <div class="page-header clearfix">
                        <h3 class="pull-left">Links</h3>
                        <a href="topcontent/Links" class="see-detail pull-right">See all <i class="fa fa-angle-right"></i></a>
                    </div>
                    <!-- /page-header -->
                    <div class="recommended-content">
                        <div class="topcontent-landing topcontent-link">
                            <div class="container-fluid">
                                <div class="row">
                                    <div each={value, key in state.topcontent.contentData.links} class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
                                        <div class="grid-thumb">
                                            <div class="thumb">
                                                <img src="{value.picture}" class="img-responsive">
                                            </div>
                                            <div class="topcontent-caption clearfix">
                                                <a href="{value.link}" target="_blank" class="linkto-post">
                                                    <div class="source">
                                                        <h4 data-toggle="tooltip" data-placement="bottom" title="{value.link_name} - {value.page_name}">{value.link_name}</h4>
                                                        <p>{value.link_description}</p>
                                                        <p> Source: <a href="https://facebook.com/{value.page_id}">{value.page_name}</a></p>
                                                    </div>
                                                    <div class="content-stats">
                                                        <span class="stats stats-like"><i class="fa fa-thumbs-up"></i> {formater.formatNumber(value.likes_count)}</span>
                                                        <span class="stats stats-comment"><i class="fa fa-comment"></i> {formater.formatNumber(value.comments_count)}</span>
                                                        <span class="stats stats-time"><i class="fa fa-clock-o"></i> {formater.formatDate(value.created_time_str)}</span>
                                                    </div>
                                                </a>
                                            </div>
                                            <!-- /topcontent-caption -->
                                            <div class="thumb-over">
                                                <a href="#" class="btn" data-type="link" onclick={shareThis} data-toggle="tooltip" data-placement="top" title="Share"><i class="fa fa-share"></i></a>
                                            </div>
                                            <!-- /thumb-over -->
                                        </div>
                                        <!-- /grid-thumb -->
                                    </div>
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
                <div class="recommended-for-you content-block">
                    <div class="page-header clearfix">
                        <h3 class="pull-left">Videos</h3>
                        <a href="topcontent/Videos" class="see-detail pull-right">See all <i class="fa fa-angle-right"></i></a>
                    </div>
                    <!-- /page-header -->
                    <div class="topcontent-landing topcontent-video">
                        <div class="container-fluid">
                            <div class="row">
                                <div each={value, key in state.topcontent.contentData.videos} class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
                                    <div class="grid-thumb">
                                        <div class="thumb">
                                            <img src="{value.thumbnail}" class="img-responsive">
                                        </div>
                                        <div class="topcontent-caption">
                                            <a href="https://www.youtube.com/watch?v={value.id}" target="_blank" class="linkto-post">
                                                <div class="source">
                                                    <h4 data-toggle="tooltip" data-placement="bottom" title="{value.title}">{value.title}</h4>
                                                    <p>{value.description}</p>
                                                </div>
                                                <div class="content-stats">
                                                    <span class="stats stats-view"> <i class="fa fa-eye"></i> {formater.formatNumber(value.statistics.viewCount)}</span>
                                                    <span class="stats stats-comment"> <i class="fa fa-comment-o"></i> {formater.formatNumber(value.statistics.commentCount)}</span>
                                                    <span class="stats stats-likes"><i class="fa fa-thumbs-o-up"></i> {formater.formatNumber(value.statistics.likeCount)}</span>
                                                    <span class="stats stats-dislikes"><i class="fa fa-thumbs-o-down"></i> {formater.formatNumber(value.statistics.dislikeCount)}</span>
                                                    <span class="stats stats-time"><i class="fa fa-clock-o"></i> {formater.formatDate(value.published_at,'YYYY-MM-DDThh:mm:ss.sZ')}</span>
                                                </div>
                                            </a>
                                        </div>
                                        <!-- /topcontent-caption -->
                                        <div class="thumb-over">
                                            <a href="#" class="btn" data-toggle="tooltip" data-placement="top" onclick={shareYoutube} title="Share"><i class="fa fa-share"></i></a>
                                            <a href="#" onclick={showPreview} data-type="videos" data-mode="youtube" class="btn" data-toggle="tooltip" data-placement="top" title="preview"><i class="fa fa-play"></i></a>
                                        </div>
                                    </div>
                                    <!-- /grid-thumb -->
                                </div>
                            </div>
                        </div>
                        <!-- /recommended-content -->
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
            // const Masonry = require('masonry-layout')
            // const imagesLoaded = require('imagesloaded')
            //let msnry;


        store.subscribe(function() {
            this.state = store.getState()

            if (this.state.topcontent.isLoadingContent) {

                uiloader.blockEl()
            } else {

                uiloader.unblockEl()
            }
            this.update()
        }.bind(this))

        this.on('updated', function() {
            //msnry.reloadItems()
            $('[data-toggle="tooltip"]').tooltip()
        })



        this.on('init_masonry', function() {
            msnry = new Masonry('.grid', {
                // options...
                itemSelector: '.grid-item',
                percentPosition: true
            })

        })
        this.on('mount', function() {
            this.state = store.getState()
            this.formater = formater

            let data = {}
            data.contentType = this.opts.contentType
            if (this.opts.contentType == "type") {

                switch (this.opts.type) {
                    case "Videos":
                        data.id = 3
                        break;
                    case "Links":
                        data.id = 2
                        break;
                    case "Pictures":
                        data.id = 1
                        break;
                }
            } else {

                data.id = this.opts[this.opts.contentType]
            }
            console.log(data)

            store.dispatch(actions.topcontent.loadContent(data))

            $(this.root).addClass('push250 detail-page')
            let sameHeight = $(this.root).outerHeight();
            $('div#slide-block').css('height', sameHeight + 'px')

            // this.trigger('init_masonry')

        })

        imgLoaded(e) {
            msnry.layout()
        }

        showPreview(e) {

            observables.preview.trigger('show_media_preview', {
                item: e.item,
                mode: e.currentTarget.dataset.mode,
                source: 'topcontent_front',
                length: this.state.topcontent.contentData[e.currentTarget.dataset.type].length
            })

        }
        shareThis(e) {

            let data = {}
            data.source = 'topcontent_' + e.currentTarget.dataset.type

            data.item = e.item

            observables.preview.trigger('open_share_dialog', data)
        }
        shareYoutube(e) {

            let data = {}
            data.source = 'youtube'

            data.item = e.item

            observables.preview.trigger('open_share_dialog', data)
        }
    </script>

</app-topcontent>