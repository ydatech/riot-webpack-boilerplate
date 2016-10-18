<grafy-background-box>
    <ul class="sidebar-box__list unstyled-list">
        <li class="sidebar-box__item {state.ui.sidebarBoxActive == 'stock'?'is-active':''}">
            <a onclick={changeBox} data-menu="stock" class="sidebar-box__link clearfix">Stocks <i class="fa {state.ui.sidebarBoxActive == 'stock'?'fa-angle-down':'fa-angle-right'} pull-right"></i></a>
            <div id="acc-one" class="sidebar-box__content {state.ui.sidebarBoxActive == 'stock'?'is-active':''} stock">
                <div class="searchbox">
                    <form>
                        <input class="searchbox__input" type="text" name="search" placeholder="Search stock images..">
                    </form>
                </div>
                <a class="stock__link" href="#"><img class="stock__img" src="" alt=""></a>

            </div>
        </li>
        <li class="sidebar-box__item {state.ui.sidebarBoxActive == 'pixabay'?'is-active':''}">
            <a onclick={changeBox} data-menu="pixabay" class="sidebar-box__link clearfix">pixabay.com <i class="fa {state.ui.sidebarBoxActive == 'pixabay'?'fa-angle-down':'fa-angle-right'} pull-right"></i></a>
            <div id="acc-two" class="sidebar-box__content {state.ui.sidebarBoxActive == 'pixabay'?'is-active':''}">
                <div class="searchbox">
                    <form>
                        <input class="searchbox__input" type="text" name="search" placeholder="Search stock images..">
                    </form>
                </div>
                <a class="stock__link" href="#"><img class="stock__img" src="" alt=""></a>

            </div>
        </li>
    </ul>
    <script>
        const $ = require('jquery')
        const store = this.opts.store
        const actions = require('../../scripts/actions/index.js')

        store.subscribe(function() {
            this.state = store.getState()
            this.update()
        }.bind(this))

        this.on('mount', function() {

            this.state = store.getState()
            this.update()

            console.log(this.state.ui.sidebarBoxActive)

        })
        changeBox(e) {
            let menu = e.currentTarget.dataset.menu
            store.dispatch(actions.ui.activateSidebarBox(menu))


        }
    </script>
</grafy-background-box>