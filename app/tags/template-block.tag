<app-template-block>
<div class="template-sidebar">
    <div class="search-form">
        <h4 class="page-header">
            Templates
        </h4>
        <!--
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
        -->


    </div>
    <div class="side-nav template-nav">
        <ul class="clearfix">
            <li class={active:state.template.activeType=='regular' }><a onclick={goToDetails} href="#" data-type="regular"><i class="fa fa-paint-brush"></i> <span class="hidden-xs">Regular Templates <i class="fa fa-angle-right pull-right"></i></span></a></li>
            <li class={active:state.template.activeType=='monthly' }><a onclick={goToDetails} href="#" data-type="monthly"><i class="fa fa-paint-brush"></i> <span class="hidden-xs">Monthly Templates<i class="fa fa-angle-right pull-right"></i></span></a></li>
            <li class={active:state.template.activeType=='draft' }><a onclick={goToDetails} href="#" data-type="draft"><i class="fa fa-paint-brush"></i> <span class="hidden-xs">Draft Templates <i class="fa fa-angle-right pull-right"></i></span></a></li>
        </ul>
    </div>
    <!--/search-result-->
</div>
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

        goToDetails(e) {

            riot.route('template/' + e.currentTarget.dataset.type)
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
</app-template-block>