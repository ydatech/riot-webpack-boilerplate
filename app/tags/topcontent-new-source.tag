<app-topcontent-new-source>
    <div class="row">
        <div class="col-lg-12">
            <div class="main-page-header clearfix">
                <div class="breadcrumb">
                    <span><a href="/topcontent">Top Content </a><i class="fa fa-angle-right"></i> <a href="/topcontent/{opts.type}">{opts.type}</a> <i if={state.topcontent.category.id} class="fa fa-angle-right"></i> <a if={state.topcontent.category.id} href="/topcontent/{opts.type}/{state.topcontent.category.id}">{state.topcontent.category.category_name}</a> <i class="fa fa-angle-right"> </i> Add New Source</span>
                </div>
            </div>
            <!-- /page-header -->
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="content-block topcontent-result">
                <div class="page-header clearfix">
                    <h3> Add New Source </h3>
                </div>
                <div class="topcontent-search-content">
                    <form onsubmit={searchKeyword} data-type="submit">
                        <div class="search-input">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Search..." value="{state.topcontent.keyword}" name="keyword" required>
                                <div class="input-group-btn">
                                    <button class="btn btn-search borderless-btn" type="submit"><i class="fa fa-search"></i></button>
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="no-result" if={keyword.value.length> 0 && state.topcontent.contentData.data
                        < 1} class="text-center">

                            <h1> Sorry!</h1>
                            <hr>
                            <p>Try another keyword!</p>
                    </div>
                    <!-- /no-result -->
                </div>
                <!-- /topcontent-search-content -->
                <div class="topcontent-search-result">
                    <ul class="media-list">
                        <li each={ value, key in state.topcontent.contentData.data} class="media">
                            <div class="media-left">
                                <a target="_blank" href="https://facebook.com{value.id}">
                                    <img class="media-object" src="{value.picture.data.url}" alt="{value.name}">
                                </a>
                            </div>
                            <div class="media-body">
                                <h4 class="media-heading">{value.name}</h4>
                                <p>{value.about}</p>
                                <div class="this-stats-wrap">
                                    <span class="stats stats-retweet"> <i class="fa fa-thumbs-o-up"></i> {formater.formatNumber(value.likes)}</span>
                                    <span class="stats stats-retweet"> <i class="fa fa-microphone"></i> {formater.formatNumber(value.talking_about_count)}</span>
                                </div>
                            </div>
                            <div if={!value.isAdded} class="media-right">
                                <a href="#" onclick={addThisPage} class="btn borderless-btn borderless-btn pull-right"> <i if={value.isBeingAdded} class="fa fa-icon ajax-loading-icon fa-spin fa-spinner"></i> Add This Page</a>
                            </div>

                        </li>
                    </ul>
                </div>
                <div if={state.topcontent.contentData.paging.cursors.after} class="more-button text-center">
                    <a onclick={loadMore} class="btn borderless-btn borderless-btn" disabled={state.topcontent.isLoadingMoreContent}> <i class="fa fa-icon {state.topcontent.isLoadingMoreContent ? 'ajax-loading-icon fa-spin fa-spinner':'fa-refresh'}"></i> {state.topcontent.isLoadingMoreContent?'Loading More ..':'Load More ..'}</a>
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
            let resultTc = $('.topcontent-search-result .media-list .media').outerWidth()
            resultTc = resultTc - 300
            $('.topcontent-search-result .media-list .media p').css('width', resultTc + 'px')
        })

        $(window).resize(function() {
            let resultTc = $('.topcontent-search-result .media-list .media').outerWidth()
            resultTc = resultTc - 300
            $('.topcontent-search-result .media-list .media p').css('width', resultTc + 'px')
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
            if (this.opts.contentType == " type ") {

                switch (this.opts.type) {
                    case "Videos ":
                        data.id = 3
                        break;
                    case "Links ":
                        data.id = 2
                        break;
                    case "Pictures ":
                        data.id = 1
                        break;
                }
            } else {

                data.id = this.opts[this.opts.contentType]
            }
            console.log(data)

            //store.dispatch(actions.topcontent.loadContent(data))

            $(this.root).addClass('push250 detail-page')
            let sameHeight = $(this.root).outerHeight();
            $('div#slide-block').css('height', sameHeight + 'px')

            // this.trigger('init_masonry')

        })

        searchKeyword(e) {

            store.dispatch(actions.topcontent.findSource(this.keyword.value, 'new'))
        }

        loadMore(e) {
            store.dispatch(actions.topcontent.findSource(this.keyword.value, 'more'))
        }

        addThisPage(e) {

            store.dispatch(actions.topcontent.createNewSource(e.item))
        }
    </script>
</app-topcontent-new-source>