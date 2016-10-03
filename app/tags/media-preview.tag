<app-media-preview>
    <div class="overlay-content">
        <div class="container-fluid">
            <div class="row yt-row" if={mode=='youtube' }>
                <div class="col-xs-12 col-sm-8">
                    <div class="yt-wrap preview-wrap">

                        <iframe width="640" height="480" src="https://www.youtube.com/embed/{item.value.id}?rel=0&showinfo=0&autoplay=1" frameborder="0" allowfullscreen=""></iframe>
                    </div>
                    <!--/yt-->

                </div>
                <div class="col-xs-12 col-sm-4">
                    <div class="right-side-desc">
                        <h4>{item.value.title}</h4>
                        <div class="this-stats-wrap">
                            <span class="stats stats-view"> <i class="fa fa-eye"></i> {formater.formatNumber(item.value.statistics.viewCount)}</span>
                            <span class="stats stats-comment"> <i class="fa fa-comment-o"></i> {formater.formatNumber(item.value.statistics.commentCount)}</span>
                            <span class="stats stats-like"><i class="fa fa-thumbs-o-up"></i> {formater.formatNumber(item.value.statistics.likeCount)}</span>
                            <span class="stats stats-dislike"><i class="fa fa-thumbs-o-down"></i> {formater.formatNumber(item.value.statistics.dislikeCount)}</span>
                            <span class="stats stats-time"><i class="fa fa-clock-o"></i> {formater.formatDate(item.value.published_at,'YYYY-MM-DDThh:mm:ss.sZ')}</span>
                        </div>
                        <div class="share-wrap">
                            <a class="btn btn-share-overlay" onclick={shareThis} href="#"><i class="fa fa-share"></i> Share</a>
                        </div>


                        <p content="{formater.convertToHTML(item.value.description)}" data-is="raw">
                        </p>


                    </div>

                </div>
            </div>
            <div if={mode=='flickr' } class="row flickr-row">
                <div class="col-xs-12 col-sm-8">
                    <div class="fl-wrap preview-wrap">
                        <img src="{item.value.url_big}" onload={imgLoaded} alt="{item.value.title}">
                    </div>
                    <!--/flickr-->
                </div>
                <div class="col-xs-12 col-sm-4">
                    <div class="right-side-desc">
                        <h4>{item.value.title}</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-4 col-sm-offset-8 col-md-4 col-md-offset-8 col-lg-4 col-lg-offset-8">
                        <div class="share-wrap">
                            <a class="btn btn-share-overlay" onclick={shareThis} href="#"><i class="fa fa-share"></i> Share</a>
                        </div>
                    </div>
                </div>
            </div>
            <div if={mode=='topcontent_picture' } class="row flickr-row">
                <div class="col-xs-12 col-sm-8">
                    <div class="fl-wrap preview-wrap">
                        <img src="{item.value.picture}" onload={imgLoaded} alt="{item.value.source.page_name}">
                    </div>
                    <!--/flickr-->
                </div>
                <div class="col-xs-12 col-sm-4">
                    <div class="right-side-desc">
                        <h4>{item.value.source.page_name}{item.value.page_name}</h4>
                        <div class="this-stats-wrap">
                            <span class="stats stats-like"><i class="fa fa-thumbs-up"></i> {formater.formatNumber(item.value.likes_count)}</span>
                            <span class="stats stats-comment"><i class="fa fa-comment"></i> {formater.formatNumber(item.value.comments_count)}</span>
                            <span class="stats stats-time"><i class="fa fa-clock-o"></i> {formater.formatDate(item.value.created_time_str)}</span>
                        </div>
                        <div class="share-wrap">
                            <a class="btn btn-share-overlay" onclick={shareThis} href="#"><i class="fa fa-share"></i> Share</a>
                        </div>
                    </div>
                </div>
            </div>
            <div if={mode=='cb_picture' } class="row flickr-row">
                <div class="col-xs-12 col-sm-8">
                    <div class="fl-wrap preview-wrap">
                        <img src="{item.value.content}" onload={imgLoaded} alt="{}">
                    </div>
                    <!--/flickr-->
                </div>
                <div class="col-xs-12 col-sm-4">
                    <div class="right-side-desc">
                        <p>{item.value.description}</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-4 col-sm-offset-8 col-md-4 col-md-offset-8 col-lg-4 col-lg-offset-8">
                        <div class="share-wrap">
                            <a class="btn btn-share-overlay" onclick={shareThis} href="#"><i class="fa fa-share"></i> Share</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--/share-btn-->
    </div>
    <!--/overlay-content-->
    <div class="overlay-nav">
        <a onclick={exitOverlay} class="close-overlay" href="#"><i class="fa fa-times"></i></a>
        <a if={item.key> 0} onclick={previousItem} class="nav-left over-nav" href="#"><i class="fa fa-angle-left"></i></a>
        <a if={item.key < length} onclick={nextItem} class="nav-right over-nav" href="#"><i class="fa fa-angle-right"></i></a>
    </div>
    <!--/overlay-nav-->
    <!--/sociocaster-overlay-->

    <script>
        const observables = require('../scripts/observables/index.js')
        const store = this.opts.store
        const actions = require('../scripts/actions/index.js')
        const notification = require('../scripts/notification.js')
        const formater = require('../scripts/formater.js')
        const uiloader = require('../scripts/uiloader.js')
        const $ = require('jquery')


        store.subscribe(function() {
            this.state = store.getState()

            this.update()

        }.bind(this))

        observables.preview.on('show_media_preview', function(data) {
            console.log('test')
            this.mode = data.mode
            this.item = data.item
            this.source = data.source
            this.length = data.length - 1
            this.update()
            $('body').css('overflow', 'hidden')
            $(this.root).fadeIn()
            uiloader.blockEl('.fl-wrap')
        }.bind(this))


        exitOverlay(e) {
            $(this.root).hide()
            this.mode = 'off'
            this.item = {}
            $('body').css('overflow', 'auto')

            this.update()
        }

        nextItem(e) {
            this.item.key = this.item.key + 1
            this.trigger('update_media_item')

        }
        this.on('update_media_item', function() {
            switch (this.mode) {
                case 'youtube':
                    if (this.source == 'keyword')
                        this.item.value = this.state.search.results.youtube.videos[this.item.key]
                    else if (this.source == 'topcontent')
                        this.item.value = this.state.topcontent.contentData.items[this.item.key]
                    else if (this.source == 'topcontent_front')
                        this.item.value = this.state.topcontent.contentData.videos[this.item.key]
                    break;
                case 'flickr':
                    this.item.value = this.state.search.results.flickr.photos[this.item.key]
                    break;
                case 'topcontent_picture':
                    if (this.source == 'topcontent')
                        this.item.value = this.state.topcontent.contentData.items[this.item.key]
                    else if (this.source == 'topcontent_front')
                        this.item.value = this.state.topcontent.contentData.pictures[this.item.key]
                    else if (this.source == 'topcontent_picture')
                        this.item.value = this.state.dashboard.recommendedItems[this.item.key]
                    break;
            }
            this.update()
            uiloader.blockEl('.img-preview')
        })
        previousItem(e) {
            this.item.key = this.item.key - 1
            this.trigger('update_media_item')

        }
        this.on('mount', function() {
            $(this.root).hide()
            this.state = store.getState()
            this.formater = formater

        })

        imgLoaded(e) {

            uiloader.unblockEl('.fl-wrap')
        }

        shareThis(e) {


            let data = {}

            data.source = this.mode

            data.item = this.item
            this.exitOverlay(e)
            observables.preview.trigger('open_share_dialog', data)


        }
    </script>
</app-media-preview>