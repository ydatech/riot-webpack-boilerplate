<app-topcontent-block>

    <div class="second-sidebar">
        <h4 class="page-header"><i class="fa fa-newspaper-o fa-fw"></i> Top Content</h4>
    </div>
    <div id="topcontent-block" class="topcontent-sidebar">
        <ul>
            <li each={ typevalue, typekey in state.topcontent.items}>
                <!-- onclick={typevalue.expand?unexpandType:expandType}-->
                <a class="clearfix {active-menu: typevalue.type==state.topcontent.activeType}" onclick={typevalue.expand?unexpandType:loadContentFromType} href="#" data-type="{value.type}"><i class="fa {typevalue.expand?'fa-folder-open':'fa-folder'}"></i> {typevalue.type} <i class="fa {typevalue.expand?'fa-angle-down':'fa-angle-right'} pull-right"></i></a>
                <ul if={typevalue.type !=='Videos' && typevalue.expand}>
                    <li each={categoryvalue, categorykey in typevalue.categories}>
                        <!--onclick={categoryvalue.expand?unexpandCategory:expandCategory}-->
                        <a onclick={categoryvalue.expand?unexpandCategory:loadContentFromCategory} data-type="{typevalue.type}" href="#" class={active-menu:categoryvalue.id==state.topcontent.activeCategory}><i class="fa {categoryvalue.expand?'fa-folder-open':'fa-folder'}"></i>  
                        <!--<span data-typekey="{typekey}" onfocus={startUpdateCategoryName} onblur={updateCategoryName} contenteditable={categoryvalue.editable}>{categoryvalue.category_name}</span> -->
                        {categoryvalue.category_name}
                        <i class="fa {categoryvalue.expand?'fa-angle-down':'fa-angle-right'} pull-right"></i></a>
                        <ul if={categoryvalue.expand}>
                            <li each={sourcevalue, sourcekey in categoryvalue.sources}>
                                <a onclick={loadContentFromSource} href="#" data-type="{typevalue.type}" data-category="{categoryvalue.id}" class="clearfix {active-menu:sourcevalue.id==state.topcontent.activeSource}">
                                    <i if={typevalue.type=="Pictures" } class="fa fa-photo"></i>
                                    <i if={typevalue.type=="Links" } class="fa fa-link"></i>
                                    <!-- <span onfocus={startUpdateSourceName} onblur={updateSourceName} contenteditable={categoryvalue.editable}> {sourcevalue.page_name} </span>-->
                                    {sourcevalue.page_name}
                                </a>
                            </li>
                            <li if={categoryvalue.editable}> <a href="/topcontent/{typevalue.type}/{categoryvalue.id}/new"><i class="fa fa-plus"></i> Add New Source</a></li>
                        </ul>
                    </li>
                    <li> <a onclick={createNewCategory} href="#" class="clearfix"><i class="fa fa-plus"></i> Create New Folder</a></li>
                </ul>

                <ul if={typevalue.type=='Videos' && typevalue.expand}>
                    <li each={categoryvalue,categorykey in typevalue.categories}>
                        <a class={active-menu:categoryvalue.id==state.topcontent.activeCategory} onclick={loadContentFromCategory} href="#" data-type="{typevalue.type}">
                            <i class="fa fa-video"></i> {categoryvalue.page_name}
                        </a>
                    </li>

                </ul>
            </li>

        </ul>
    </div>
    <!--/search-result-->
    <script>
        const $ = require('jquery')
        const store = this.opts.store
        const actions = require('../scripts/actions/index.js')
        const notification = require('../scripts/notification.js')
        const uiloader = require('../scripts/uiloader.js')


        store.subscribe(function() {
            this.state = store.getState()
            this.update()
            console.log('something changed')

            if (this.state.topcontent.isLoadingTopContent) {

                uiloader.blockEl(this.root)
            } else {

                uiloader.unblockEl(this.root)
            }

        }.bind(this))

        expandType(e) {
            e.item.typevalue.expand = true

        }

        unexpandType(e) {
            e.item.typevalue.expand = false

            riot.route('topcontent')

        }

        expandCategory(e) {
            console.log(e)
            if (!this.editableSource) {
                e.item.categoryvalue.expand = true
            }
        }

        unexpandCategory(e) {
            //if (!this.editableSource) {
            e.item.categoryvalue.expand = false
            if (this.state.topcontent.filter !== 'all')
                riot.route(`topcontent/${e.currentTarget.dataset.type}?filter=${this.state.topcontent.filter}`)
            else
                riot.route(`topcontent/${e.currentTarget.dataset.type}`)
                //}
        }



        startUpdateCategoryName(e) {

            store.dispatch(actions.topcontent.editingCategory(true))
        }



        updateCategoryName(e) {
            store.dispatch(actions.topcontent.editingCategory(false))

            if (e.item.categoryvalue.category_name !== e.currentTarget.innerText) {
                store.dispatch(actions.topcontent.updateCategory({
                    typekey: e.currentTarget.dataset.typekey,
                    categorykey: e.item.categorykey,
                    categoryvalue: e.item.categoryvalue,
                    new_category_name: e.currentTarget.innerText
                }))
            }
        }
        loadContentFromSource(e) {
            //console.log(`topcontent/${e.currentTarget.dataset.type}/${e.currentTarget.dataset.category}/${e.item.sourcevalue.id}?filter=${this.state.topcontent.filter}`)
            if (this.state.topcontent.filter !== 'new')
                riot.route(`topcontent/${e.currentTarget.dataset.type}/${e.currentTarget.dataset.category}/${e.item.sourcevalue.id}?filter=${this.state.topcontent.filter}`)
            else
                riot.route(`topcontent/${e.currentTarget.dataset.type}/${e.currentTarget.dataset.category}/${e.item.sourcevalue.id}`)
        }
        loadContentFromType(e) {
            if (e.item.typevalue.type !== 'Videos') {
                if (this.state.topcontent.filter !== 'new')
                    riot.route(`topcontent/${e.item.typevalue.type}?filter=${this.state.topcontent.filter}`)
                else
                    riot.route(`topcontent/${e.item.typevalue.type}`)
            } else {
                riot.route(`topcontent/${e.item.typevalue.type}?region=${this.state.topcontent.region}`)
            }
        }
        loadContentFromCategory(e) {

            console.log(e)
            if (!this.state.topcontent.isEditingCategory) {
                if (e.currentTarget.dataset.type !== 'Videos') {
                    if (this.state.topcontent.filter !== 'new')
                        riot.route(`topcontent/${e.currentTarget.dataset.type}/${e.item.categoryvalue.id}?filter=${this.state.topcontent.filter}`)
                    else
                        riot.route(`topcontent/${e.currentTarget.dataset.type}/${e.item.categoryvalue.id}`)
                } else {
                    riot.route(`topcontent/${e.currentTarget.dataset.type}/${e.item.categoryvalue.id}?region=${this.state.topcontent.region}`)


                }

            }



        }
        createNewCategory(e) {
            console.log(e)

            store.dispatch(actions.topcontent.createNewCategory(e.item))
        }


        this.on('mount', function() {
            this.state = store.getState()

            store.dispatch(actions.topcontent.initTopContent())
            $(this.root).addClass('active')
            $('div#main').css('min-height', screen.height - 150 + "px")
            this.update()

        })
        this.on('unmount', function() {
            $(this.root).removeClass('active')
            $('div#main').removeClass('push250 detail-page')
        })
    </script>
</app-topcontent-block>