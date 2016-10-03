<app-keyword-block>

    <div class="search-form">
        <h4 class="page-header">
            Search by Keyword
        </h4>

        <div class="search-box">

            <div class="search-provider clearfix">
                <div class="switch pull-left">
                    <a onclick={toggleProvider} data-provider="twitter" class={active : state.search.providers.indexOf( 'twitter')> -1}><i class="fa fa-twitter"></i></a>
                </div>
                <div class="switch pull-left">
                    <a onclick={toggleProvider} data-provider="youtube" class={active : state.search.providers.indexOf( 'youtube')> -1 }><i class="fa fa-youtube"></i></a>
                </div>
                <div class="switch pull-left">
                    <a onclick={toggleProvider} data-provider="flickr" class={active : state.search.providers.indexOf( 'flickr')> -1 }><i class="fa fa-flickr"></i></a>
                </div>
            </div>
            <!--/search-provider-->
            <form onsubmit={searchKeyword} data-type="submit">
                <div class="search-input">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search..." value="{state.search.keyword}" name="keyword" required>
                        <div class="input-group-btn">
                            <button class="btn btn-search borderless-btn" type="submit"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                </div>



            </form>
        </div>
        <!--/search-box-->

    </div>
    <div if={keyword.value.length> 0} class="search-result-nav">
        <ul class="clearfix">
            <li if={state.search.providers.indexOf( 'twitter')> -1} class={active:state.search.activeProvider == 'twitter'}><a onclick={searchKeyword} href="#" data-provider="twitter" data-type="click"><i class="fa fa-twitter-square"></i> <span class="hidden-xs">Twitter Search Results <i class="fa fa-angle-right pull-right"></i></span></a></li>
            <li if={state.search.providers.indexOf( 'youtube')> -1} class={active:state.search.activeProvider == 'youtube'}><a onclick={searchKeyword} href="#" data-provider="youtube" data-type="click"><i class="fa fa-youtube"></i> <span class="hidden-xs">Youtube Search Results <i class="fa fa-angle-right pull-right"></i></span></a></li>
            <li if={state.search.providers.indexOf( 'flickr')> -1} class={active:state.search.activeProvider == 'flickr'}><a onclick={searchKeyword} href="#" data-provider="flickr" data-type="click"><i class="fa fa-flickr"></i> <span class="hidden-xs">Flickr Search Results <i class="fa fa-angle-right pull-right"></i></span></a></li>
        </ul>
    </div>
    <!--/search-result-->
    <script>
        const $ = require('jquery')
        const store = this.opts.store
        const actions = require('../scripts/actions/index.js')
        const notification = require('../scripts/notification.js')


        store.subscribe(function() {
            this.state = store.getState()
            this.update()




        }.bind(this))


        toggleProvider(e) {
            //console.log(this.state.search.providers.indexOf('twitter'))
            let provider = e.currentTarget.dataset.provider
            store.dispatch(actions.search.setProviders(provider))

        }

        this.on('updated', function() {

            let resultTextTwitter = $('.result-twitter .result-list .media').outerWidth()
            let resultTextYt = $('.result-youtube .result-list .media').outerWidth()
            let resultTextF = $('.result-flickr .result-list .media').outerWidth()
            resultTextTwitter = resultTextTwitter - 200;
            resultTextYt = resultTextYt - 300;
            resultTextF = resultTextF - 300;
            $('.result-twitter .result-list .media-list .media p').css('width', resultTextTwitter + 'px')
            $('.result-youtube .result-list .media-list .media p').css('width', resultTextYt + 'px')
            $('.result-flickr .result-list .media-list .media p').css('width', resultTextF + 'px')

        })

        $(window).resize(function() {
            let resultTextTwitter = $('.result-twitter .result-list .media').outerWidth()
            let resultTextYt = $('.result-youtube .result-list .media').outerWidth()
            let resultTextF = $('.result-flickr .result-list .media').outerWidth()
            resultTextTwitter = resultTextTwitter - 200;
            resultTextYt = resultTextYt - 300;
            resultTextF = resultTextF - 300;
            $('.result-twitter .result-list .media-list .media p').css('width', resultTextTwitter + 'px')
            $('.result-youtube .result-list .media-list .media p').css('width', resultTextYt + 'px')
            $('.result-flickr .result-list .media-list .media p').css('width', resultTextF + 'px')
            let mainNode = $("#main");
            mainNode.css('min-height', screen.height - 150 + "px")
        })

        searchKeyword(e) {
            this.isSubmitted = true
            if (this.state.search.providers.length < 1) {
                notification('Choose at least one provider', 'error')
            } else if (this.keyword.value.length < 1) {
                notification('Please input your keyword', 'error')
            } else {
                let params = $.param({
                        //p: this.state.search.providers,
                        k: encodeURI(this.keyword.value)
                    })
                    //console.log(decodeURIComponent(params))
                if (e.currentTarget.dataset.type == 'submit') {
                    riot.route(`keyword/${this.state.search.providers[0]}?k=${this.keyword.value}`)
                } else {
                    riot.route(`keyword/${e.currentTarget.dataset.provider}?k=${this.keyword.value}`)

                }
            }


        }
        directSearchKeyword(e) {

        }


        this.on('mount', function() {
            this.state = store.getState()

            $(this.root).addClass('active')
            $('div#main').css('min-height', screen.height - 150 + "px")
            this.update()

        })
        this.on('unmount', function() {
            $(this.root).removeClass('active')
            $('div#main').removeClass('push250 detail-page')
        })
    </script>
</app-keyword-block>