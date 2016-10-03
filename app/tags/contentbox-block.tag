<app-contentbox-block>
    <div class="cb-sidebar">
        <div class="tab-sidebar tabs">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active">
                    <a href="#add-cb" aria-controls="home" role="tab" data-toggle="tab"><i class="fa fa-plus"></i> Add</a>
                </li>
                <li role="presentation">
                    <a href="#search-cb" aria-controls="profile" role="tab" data-toggle="tab"><i class="fa fa-search"></i> Search</a>
                </li>
            </ul>
            <!-- Tab panes -->
        </div>
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="add-cb">
                <div class="search-form">
                    <h4 class="page-header">
                        Add Content Box
                    </h4>
                    <div class="search-box add-cb">
                        <!--/search-provider-->
                        <form onsubmit={addNewBox} data-type="submit">
                            <div class="search-input">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Type a name for new Content Box.." value="" name="contentboxName" maxlength="50" required>
                                    <div class="input-group-btn">
                                        <button class="btn btn-search borderless-btn" type="submit"><i class="fa {state.contentbox.isCreatingBox?'fa-spin fa-spinner': 'fa-plus'}"></i></button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!--/search-box add-cb-->
                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="search-cb">
                <div class="search-form">
                    <h4 class="page-header">
                        Search Content Box
                    </h4>
                    <div class="search-box search-cb">
                        <!--/search-provider-->
                        <form onsubmit={searchBox} data-type="submit">
                            <div class="search-input">
                                <div class="input-group">
                                    <input type="text" class="form-control" onkeyup={searchBox} placeholder="Search for Content Box.." value="" name="searchContentboxKeyword" maxlength="50" required>
                                    <div class="input-group-btn">
                                        <button class="btn btn-search borderless-btn" type="submit"><i class="fa fa-search"></i></button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!--/search-box search-cb-->
                </div>
            </div>
        </div>
        <div class="side-nav contentbox-list">
            <ul class="clearfix">
                <li each={value, key in state.contentbox.items.filter(filterBoxes)}>
                    <a href="/contentbox/{value.id}" class={active:state.contentbox.activeItem.id==value.id }> <i class="fa fa-cloud-download"></i> <span class="">{value.name}<i class="fa fa-angle-right pull-right"></i></span></a>
                </li>
                <li if={state.contentbox.items.filter(filterBoxes).length < 1} class="noresult">
                        <i class="fa fa-frown-o"></i> No result
                    </li>
            </ul>
        </div>
        <!--/search-result-->
    </div>
    <!--/cb-sidebar-->
    <script>
        const $ = require('jquery')
        const store = this.opts.store
        const actions = require('../scripts/actions/index.js')
        const notification = require('../scripts/notification.js')
        const uiloader = require('../scripts/uiloader.js')


        store.subscribe(function() {
            this.state = store.getState()
            this.update()


            if (this.state.contentbox.isLoadingBox) {

                uiloader.blockEl(this.root)
            } else {

                uiloader.unblockEl(this.root)
            }


        }.bind(this))






        addNewBox(e) {
            if (this.contentboxName.value.length > 0) {
                store.dispatch(actions.contentbox.createNewBox(this.contentboxName.value))
            }

        }
        searchBox(e) {
            this.update()
        }
        filterBoxes(item) {

            if (this.searchContentboxKeyword.value.length <= 0) {

                return true

            } else {
                if (item.name.toLowerCase().indexOf(this.searchContentboxKeyword.value.toLowerCase()) > -1) {

                    return true
                } else {
                    return false
                }

            }
        }

        this.on('mount', function() {
            this.state = store.getState()
            store.dispatch(actions.contentbox.initBoxList())
            $(this.root).addClass('active')
            $('div#main').css('min-height', screen.height - 150 + "px")
            this.update()

        })
        this.on('unmount', function() {
            $(this.root).removeClass('active')
            $('div#main').removeClass('push250 detail-page')
        })
    </script>
</app-contentbox-block>