<app-topcontent-details>
    <div class="topcontent-detail">
        <div class="row">
            <div class="col-lg-12">
                <div class="main-page-header clearfix">
                    <div class="breadcrumb">
                        <span if={opts.type !=="Videos" }> <a href="/topcontent">Top Content </a><i class="fa fa-angle-right"></i> <a href="/topcontent/{opts.type}">{opts.type}</a> <i if={state.topcontent.category.id} class="fa fa-angle-right"></i> <a if={state.topcontent.category.id} href="/topcontent/{opts.type}/{state.topcontent.category.id}">{state.topcontent.category.category_name}</a> <i if={state.topcontent.source.id} class="fa fa-angle-right"></i>  <a if={state.topcontent.source.id} href="/topcontent/{opts.type}/{state.topcontent.category.id}/{state.topcontent.source.id}">{state.topcontent.source.page_name}</a></span>
                        <span if={opts.type=="Videos" }><a href="/topcontent">Top Content</a> <i class="fa fa-angle-right"></i> <a href="/topcontent/{opts.type}">{opts.type}</a> <i if={state.topcontent.category.id} class="fa fa-angle-right"></i><a if={state.topcontent.category.id} href="/topcontent/{opts.type}/{state.topcontent.category.id}">{state.topcontent.category.page_name}</a> </span>
                    </div>
                </div>
                <!-- /page-header -->
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="content-block topcontent-result">
                    <div class="page-header clearfix">

                        <h3 if={opts.type !=="Videos" } class="pull-left"><span onblur={updateCategoryName} onkeydown={updateCategoryNameOnEnter} contenteditable={state.topcontent.category.editable && !state.topcontent.source.id}>{state.topcontent.source.page_name?state.topcontent.source.page_name:state.topcontent.category.category_name?state.topcontent.category.category_name:opts.type }</span>
                            <span if={state.topcontent.contentData._meta.totalCount} class="badge">{formater.formatNumber(state.topcontent.contentData._meta.totalCount)}</span>
                        </h3>
                        <h3 if={opts.type=="Videos" } class="pull-left"> {state.topcontent.category.page_name?state.topcontent.category.page_name:opts.type }</h3>
                        <div if={(opts.type !=='Videos' && opts.contentType=='type' ) || (opts.type !=='Videos' && state.topcontent.category.sources.length> 0)} class="pull-right filter">

                            <a href="#" onclick={setFilter} data-filter="new" class={active:state.topcontent.filter=='new' }> <i class="fa fa-circle-o"></i> <i class="fa fa-dot-circle-o"></i>New</a>
                            <a href="#" onclick={setFilter} data-filter="week" class={active:state.topcontent.filter=='week' }><i class="fa fa-circle-o"></i> <i class="fa fa-dot-circle-o"></i> Week</a>
                            <a href="#" onclick={setFilter} data-filter="month" class={active:state.topcontent.filter=='month' }><i class="fa fa-circle-o"></i> <i class="fa fa-dot-circle-o"></i> Month</a>
                            <a href="#" onclick={setFilter} data-filter="all" class={active:state.topcontent.filter=='all' }><i class="fa fa-circle-o"></i> <i class="fa fa-dot-circle-o"></i> All</a>

                        </div>

                        <div if={opts.type=="Videos" } class="pull-right filter">
                            <div class="dropdown right-dropdown">
                                <button class="btn borderless-btn dropdown-toggle" type="button" data-toggle="dropdown">{state.topcontent.activeCountry.name} <span class="caret"></span></button>
                                <div class="find-area">
                                    <input type="text" name="country" placeholder="Type your country here.." onkeyup={searchCountry} value="{state.topcontent.activeCountry.name}">
                                </div>
                                <ul class="dropdown-menu">
                                    <li each={value, key in state.topcontent.countries.filter(filterCountries)}><a onclick={setVideoCountry} href="#">{value.name}</a></li>

                                </ul>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="topcontent-custom-setting">
                            <a if={state.topcontent.category.editable && !state.topcontent.source.editable} href="/topcontent/{opts.type}/{state.topcontent.category.id}/new"><i class="fa fa-plus"></i> Add New Source</a>
                            <a if={state.topcontent.category.editable} href="#" onclick={state.topcontent.source.editable?deleteSource:deleteCategory}><i class="fa fa-trash"></i> Delete</a>
                        </div>

                    </div>
                    <div class="new-topcontent" if={state.topcontent.contentData.items.length < 1}>
                        <div if={state.topcontent.category.sources.length <1}>
                            <a class="btn borderless-btn" if={state.topcontent.category.editable && !state.topcontent.source.editable} href="/topcontent/{opts.type}/{state.topcontent.category.id}/new"><i class="fa fa-plus"></i> Add New Source</a>
                            <a class="btn borderless-btn" if={state.topcontent.category.editable} href="#" onclick={state.topcontent.source.editable?deleteSource:deleteCategory}><i class="fa fa-trash"></i> Delete</a>

                        </div>
                        <p>

                        </p>
                        <div if={state.topcontent.category.sources.length> 0} class="text-center">

                            <h1> Sorry!</h1>
                            <hr>
                            <p>No content available for this time period.</p>
                            <p>Try a larger timeframe</p>
                        </div>
                    </div>
                    <!-- /page-header -->
                    <div if={opts.type !=='Videos' } class="result-list">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="grid">
                                    <div each={value, key in state.topcontent.contentData.items} class="col-xs-12 col-sm-12 col-md-6 col-lg-3 grid-item">
                                        <div class="grid-thumb">
                                            <div class="thumb">
                                                <img src="{value.picture}" class="img-responsive" onload={imgLoaded}>
                                            </div>
                                            <div class="topcontent-caption">
                                                <a href="{value.link}" target="_blank" class="thumb">
                                                    <div class="source" if={value.type=='link' }>
                                                        <h4 data-toggle="tooltip" data-placement="bottom" title="{value.link_name} - {value.source.page_name}">{value.link_name} </h4>
                                                        <p>{value.link_description}</p>
                                                        <p> Source: <a href="https://facebook.com/{value.source.page_id}">{value.source.page_name}</a></p>
                                                    </div>
                                                    <div class="source" if={value.type=='photo' }>
                                                        <p> Source: <a href="https://facebook.com/{value.source.page_id}">{value.source.page_name}</a></p>
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
                                                <div class="over-wrap">
                                                    <div class="over-inner">
                                                        <a href="#" class="btn" data-toggle="tooltip" data-placement="top" onclick={shareThis} title="Share"><i class="fa fa-share"></i></a>
                                                        <a if={value.type=='photo' } href="#" data-mode="topcontent_picture" onclick={showPreview} class="btn" data-toggle="tooltip" data-placement="top" title="preview"><i class="fa fa-eye"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /thumb-over -->
                                        </div>
                                        <!-- /grid-thumb -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div if={opts.type=='Videos' } class="result-list">
                        <div class="container-fluid">
                            <div class="row">
                                <div class=" grid grid-video">
                                    <div each={value, key in state.topcontent.contentData.items} class="col-xs-12 col-sm-12 col-md-6 col-lg-3 grid-item">
                                        <div class="grid-thumb">
                                            <div class="thumb">
                                                <img src="{value.thumbnail}" class="img-responsive" onload={imgLoaded}>
                                            </div>
                                            <div class="topcontent-caption">
                                                <a href="https://www.youtube.com/watch?v={value.id}" target="_blank" class="linkto-post">
                                                    <div class="source">
                                                        <h4 data-toggle="tooltip" data-placement="bottom" title="{value.title}">{value.title}</h4>
                                                        <p>{value.description}</p>
                                                    </div>

                                                    <div class="content-stats">
                                                        <span class="stats stats-like"> <i class="fa fa-eye"></i> {formater.formatNumber(value.statistics.viewCount)}</span>
                                                        <span class="stats stats-comment"> <i class="fa fa-comment-o"></i> {formater.formatNumber(value.statistics.commentCount)}</span>
                                                        <span class="stats stats-likes"><i class="fa fa-thumbs-o-up"></i> {formater.formatNumber(value.statistics.likeCount)}</span>
                                                        <span class="stats stats-dislikes"><i class="fa fa-thumbs-o-down"></i> {formater.formatNumber(value.statistics.dislikeCount)}</span>
                                                        <span class="stats stats-time"><i class="fa fa-clock-o"></i> {formater.formatDate(value.published_at,'YYYY-MM-DDThh:mm:ss.sZ')}</span>
                                                    </div>
                                                </a>
                                            </div>
                                            <!-- /topcontent-caption -->
                                            <div class="thumb-over">
                                                <div class="over-wrap">
                                                    <div class="over-inner">
                                                        <a href="#" class="btn" data-toggle="tooltip" onclick={shareYoutube} data-placement="top" title="Share"><i class="fa fa-share"></i></a>
                                                        <a href="#" data-mode="youtube" onclick={showPreview} class="btn" data-toggle="tooltip" data-placement="top" title="preview"><i class="fa fa-play"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /thumb-over -->
                                        </div>
                                        <!-- /grid-thumb -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- /feed-list -->
                    <div if={(state.topcontent.contentData._meta.currentPage < state.topcontent.contentData._meta.pageCount) || state.topcontent.contentData._meta.nextPageToken || state.topcontent.fbafter} class="more-button text-center">
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
            const Masonry = require('masonry-layout')
                // const imagesLoaded = require('imagesloaded')
            const observables = require('../scripts/observables/index.js')
            let msnry;


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
                msnry.reloadItems()
                $('[data-toggle="tooltip"]').tooltip()


                if ($('.topcontent-custom-setting').children().length < 1) {
                    $('.topcontent-custom-setting').css('display', 'none')
                }
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
                this.trigger('init_masonry')

            })

            imgLoaded(e) {
                msnry.layout()
            }


            setFilter(e) {
                let routeTo = (e.currentTarget.dataset.filter !== "new") ? `topcontent/${this.opts.type}?filter=${e.currentTarget.dataset.filter}` : `topcontent/${this.opts.type}`

                if (this.opts.contentType == "category")
                    routeTo = (e.currentTarget.dataset.filter !== "new") ? `topcontent/${this.opts.type}/${this.opts.category}?filter=${e.currentTarget.dataset.filter}` : routeTo = `topcontent/${this.opts.type}/${this.opts.category}`
                else if (this.opts.contentType == "source")
                    routeTo = (e.currentTarget.dataset.filter !== "new") ? `topcontent/${this.opts.type}/${this.opts.category}/${this.opts.source}/?filter=${e.currentTarget.dataset.filter}` : `topcontent/${this.opts.type}/${this.opts.category}/${this.opts.source}`


                riot.route(routeTo)
            }



            loadMore(e) {
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
                store.dispatch(actions.topcontent.loadMoreContent(data))
            }

            deleteCategory(e) {
                if (confirm(`Are you sure want to delete this category : ${this.state.topcontent.category.category_name}`)) {

                    store.dispatch(actions.topcontent.deleteTopContent('category'))

                }
            }
            deleteSource(e) {
                if (confirm(`Are you sure want to delete this source : ${this.state.topcontent.source.page_name}`)) {
                    store.dispatch(actions.topcontent.deleteTopContent('type'))

                }

            }
            searchCountry(e) {
                this.update()
            }
            filterCountries(item) {

                if (this.country.value.length <= 0) {

                    return true

                } else {
                    if (item.name.toLowerCase().indexOf(this.country.value.toLowerCase()) > -1) {

                        return true
                    } else {
                        return false
                    }

                }
            }
            updateCategoryName(e) {
                if (e.currentTarget.innerText.trim().length < 1) {
                    notification('Please input a name for this folder', 'error')
                } else if (e.currentTarget.innerText.length <= 50) {
                    if (this.state.topcontent.category.category_name !== e.currentTarget.innerText) {
                        store.dispatch(actions.topcontent.updateCategory({
                            new_category_name: e.currentTarget.innerText
                        }))
                    }
                } else {
                    notification('The folder name exceeds the maximum of 50 characters', 'error')
                }
            }

            updateCategoryNameOnEnter(e) {

                if (e.which == 13) {
                    if (e.currentTarget.innerText.trim().length < 1) {
                        notification('Please input a name for this folder', 'error')
                    } else if (e.currentTarget.innerText.length <= 50) {
                        if (this.state.topcontent.category.category_name !== e.currentTarget.innerText) {
                            $(e.currentTarget).blur()
                        }

                    } else {
                        notification('The folder name exceeds the maximum of 50 characters', 'error')

                    }
                    //Prevent insertion of a return
                    //You could do other things here, for example
                    //focus on the next 

                    return false

                } else {
                    return true
                }
            }

            setVideoCountry(e) {
                let routeToRegion = `topcontent/${this.opts.type}?region=${e.item.value.code}`
                if (this.opts.contentType == "category") {
                    routeToRegion = `topcontent/${this.opts.type}/${this.opts.category}?region=${e.item.value.code}`


                }

                riot.route(routeToRegion)

            }
            showPreview(e) {

                observables.preview.trigger('show_media_preview', {
                    item: e.item,
                    mode: e.currentTarget.dataset.mode,
                    source: 'topcontent',
                    length: this.state.topcontent.contentData.items.length
                })

            }

            shareThis(e) {

                let data = {}
                data.source = 'topcontent_' + e.item.value.type

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
</app-topcontent-details>