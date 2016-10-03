<app-feed-block>
    <div class="feed-sidebar">
        <div class="tab-sidebar tabs">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active">
                    <a href="#add-feeds" aria-controls="home" role="tab" data-toggle="tab"><i class="fa fa-plus"></i> Add</a>
                </li>
                <li role="presentation">
                    <a href="#search-feeds" aria-controls="profile" role="tab" data-toggle="tab"><i class="fa fa-search"></i> Search</a>
                </li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="add-feeds">
                    <div class="search-form">
                        <h4 class="page-header">
                            Add RSS Feeds
                        </h4>
                        <div class="search-box add-feed">
                            <!--/search-provider-->
                            <form onsubmit={addNewFeed} data-type="submit">
                                <div class="search-input">
                                    <div class="input-group">
                                        <input type="url" class="form-control" placeholder="Type your feed url.." value="{}" name="feedUrl" required>
                                        <div class="input-group-btn">
                                            <button class="btn btn-search borderless-btn" type="submit"><i class="fa {state.feed.isCreatingFeed?'fa-spin fa-spinner': 'fa-plus'}"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <!--/search-box add-feed-->
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="search-feeds">
                    <div class="search-form">
                        <h4 class="page-header">
                            Search RSS Feeds
                        </h4>
                        <div class="search-box search-feed">
                            <!--/search-provider-->
                            <form onsubmit={searchFeed} data-type="submit">
                                <div class="search-input">
                                    <div class="input-group">
                                        <input type="url" class="form-control" onkeyup={searchFeed} placeholder="Search feed.." value="{}" name="searchFeedKeyword" required>
                                        <div class="input-group-btn">
                                            <button class="btn btn-search borderless-btn" type="submit"><i class="fa fa-search"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <!--/search-box search-feed-->
                    </div>
                </div>
            </div>
            <div class="side-nav my-feed-list">
                <ul class="clearfix">
                    <li each={value, key in state.feed.items.filter(filterFeeds)}>
                        <a class="clearfix {active:state.feed.activeItem.id==value.id }" href="/feed/{value.id}"><img class="pull-left" src="{value.favicon.indexOf('https') > -1 ?value.favicon:value.favicon}"> <span class="pull-left feed-name">{value.site_title}</span><i class="fa fa-angle-right pull-right"></i></a>
                    </li>
                    <li if={state.feed.items.filter(filterFeeds).length < 1} class="noresult">
                        <i class="fa fa-frown-o"></i> No result
                    </li>
                </ul>
            </div>
            <!--/search-result-->
        </div>

        <script>
            const $ = require('jquery')
            const store = this.opts.store
            const actions = require('../scripts/actions/index.js')
            const notification = require('../scripts/notification.js')
            const uiloader = require('../scripts/uiloader.js')

            store.subscribe(function() {
                this.state = store.getState()
                this.update()


                if (this.state.feed.isLoadingFeed) {

                    uiloader.blockEl(this.root)
                } else {

                    uiloader.unblockEl(this.root)
                }


            }.bind(this))






            addNewFeed(e) {
                if (this.feedUrl.value.length > 5) {
                    store.dispatch(actions.feed.createNewFeed(this.feedUrl.value))
                }

            }
            searchFeed(e) {
                this.update()
            }
            filterFeeds(item) {

                if (this.searchFeedKeyword.value.length <= 0) {

                    return true

                } else {
                    if (item.site_title.toLowerCase().indexOf(this.searchFeedKeyword.value.toLowerCase()) > -1) {

                        return true
                    } else if (item.site_url.toLowerCase().indexOf(this.searchFeedKeyword.value.toLowerCase()) > -1) {
                        return true
                    } else if (item.feed_url.toLowerCase().indexOf(this.searchFeedKeyword.value.toLowerCase()) > -1) {
                        return true
                    } else {
                        return false
                    }

                }
            }

            this.on('mount', function() {
                this.state = store.getState()
                store.dispatch(actions.feed.initFeedList())
                $(this.root).addClass('active')
                $('div#main').css('min-height', screen.height - 150 + "px")
                this.update()

            })
            this.on('unmount', function() {
                $(this.root).removeClass('active')
                $('div#main').removeClass('push250 detail-page')
            })
        </script>
    </div>
    <!-- /feed-sidebar -->
</app-feed-block>