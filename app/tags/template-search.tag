<app-template-search>
    <div class="template-page">
        <div class="row">
            <div class="col-lg-12">
                <div class="main-page-header clearfix">
                    <div class="breadcrumb">
                        <span><a href="templates">Templates</a></span>
                    </div>
                </div>
                <!-- /page-header -->
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="content-block template-result">
                    <div class="page-header clearfix">
                        <h3> Search Templates </h3>
                    </div>
                    <div class="template-search-content">
                        <form onsubmit={searchKeyword} data-type="submit">
                            <div class="search-input">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Search..." value="{state.template.keyword}" name="searchTemplateKeyword"
                                        required>
                                    <div class="input-group-btn">
                                        <button class="btn btn-search borderless-btn" type="submit"><i class="fa fa-search"></i></button>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <div class="template-popular-keyword">
                            <h4> Popular Keywords</h4>
                            <p>
                                <span each={value, key in state.template.popular} class="badge"><a href="#" onclick={searhPopular} >{value.keyword}</a></span>
                            </p>
                        </div>
                        <div class="no-result" if={searchTemplateKeyword.value.length> 0 && state.template.search.items
                            < 1} class="text-center">
                                <h1> Sorry!</h1>
                                <hr>
                                <p>Try another keyword!</p>
                        </div>
                        <!-- /no-result -->
                    </div>
                    <!-- /topcontent-search-content -->
                    <div if={ state.template.search.items.length> 0} class="template-search-result">
                        <div class="container-fluid">
                            <div class="row grid">
                                <div class="col-xs-12">
                                    <h4> Search Results for "{state.template.keyword}" <span class="badge">{formater.formatNumber(state.template.search._meta.totalCount)}</span></h4>
                                </div>
                                <div each={value, key in state.template.search.items} class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
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
                    <div if={state.template.search._meta.currentPage < state.template.search._meta.pageCount} class="more-button text-center">
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




            store.dispatch(actions.template.loadPopular())

            $(this.root).addClass('push250 detail-page')
            let sameHeight = $(this.root).outerHeight();
            $('div#slide-block').css('height', sameHeight + 'px')

            // this.trigger('init_masonry')

        })
        searhPopular(e) {

            this.searchTemplateKeyword.value = e.item.value.keyword
            this.searchKeyword(e)
        }
        searchKeyword(e) {
            if (this.searchTemplateKeyword.value.length > 0) {
                riot.route('template?keyword=' + this.searchTemplateKeyword.value)
            } else {
                notification('Please input your keyword', 'error')
            }
        }

        loadMore(e) {
            store.dispatch(actions.template.searchMore())
        }

        addThisPage(e) {

            store.dispatch(actions.topcontent.createNewSource(e.item))
        }
    </script>
</app-template-search>