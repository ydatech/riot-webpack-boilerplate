<app-keyword>
    <div class="row">
        <div class="col-lg-12">
            <div class="main-page-header clearfix">
                <span class="top-path pull-left">Search By Keyword</span>
            </div>
            <!-- /page-header -->
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="content-block search-result">

                <div class="trending">
                    <h4 class="title pull-left">Trending in {state.search.location.name}</h4>
                    <div class="dropdown pull-right right-dropdown">
                        <button class="btn borderless-btn dropdown-toggle" type="button" data-toggle="dropdown">{state.search.location.name} <span class="caret"></span></button>
                        <div class="find-area">
                            <input type="text" name="place" onkeyup={searchPlace} value="{state.search.location.name}" placeholder="Search here..">

                        </div>
                        <ul class="dropdown-menu">
                            <li></li>
                            <li each={value, key in state.search.places.filter(filterPlaces)}><a onclick={setLocation} href="#">{value.name}</a></li>

                        </ul>
                    </div>
                    <div class="clearfix"></div>
                    <ul class="list trending-list">
                        <li each={value,key in state.search.trends}><a href="keyword/twitter?k={value.name}">{value.name}</a><span if={value.tweet_volume}>{formater.formatNumber(value.tweet_volume)} Tweets</span></li>

                    </ul>
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

            this.update()
            if (this.state.search.isLoading) {
                uiloader.blockEl()
            } else {
                uiloader.unblockEl()
            }
        }.bind(this))

        this.on('mount', function() {
            this.state = store.getState()
            this.formater = formater
            $(this.root).addClass('push250 detail-page')
            let sameHeight = $(this.root).outerHeight();
            $('div#slide-block').css('height', sameHeight + 'px');
            store.dispatch(actions.search.initPlaces())
            store.dispatch(actions.search.initTrends())

        })

        setLocation(e) {
            store.dispatch(actions.search.setLocation(e.item.value))
            store.dispatch(actions.search.initTrends())
        }
        searchPlace(e) {
            this.update()
        }
        filterPlaces(item) {

            if (this.place.value.length <= 0) {

                return true

            } else {
                if (item.name.toLowerCase().indexOf(this.place.value.toLowerCase()) > -1) {

                    return true
                } else {
                    return false
                }

            }
        }
    </script>
</app-keyword>