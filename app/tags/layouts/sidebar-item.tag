<grafy-sidebar-item>
    <div class="sidebar-nav">
        <ul class="sidebar-nav__list unstyled-list">
            <li class="sidebar-nav__item">
                <a class="sidebar-nav__link {state.ui.sidebarActive == 'background'?'is-active':''}" onclick={openBox} data-menu="background">
                    <i class="sidebar-nav__icon fa fa-file-picture-o"></i> Background
                </a>
            </li>
            <li class="sidebar-nav__item {state.ui.sidebarActive == 'materials'?'is-active':''}">
                <a class="sidebar-nav__link" onclick={openBox} data-menu="materials">
                    <i class="sidebar-nav__icon fa fa-clone"></i> Materials
                </a>
            </li>
            <li class="sidebar-nav__item {state.ui.sidebarActive == 'text'?'is-active':''}">
                <a class="sidebar-nav__link" onclick={openBox} data-menu="text"><span class="sidebar-nav__icon sidebar-nav__icon--txt">T</span> Text</a>
            </li>
            <li class="sidebar-nav__item {state.ui.sidebarActive == 'templates'?'is-active':''}">
                <a class="sidebar-nav__link" onclick={openBox} data-menu="templates"><i class="sidebar-nav__icon fa fa-paint-brush"></i> Templates</a>
            </li>
            <li class="sidebar-nav__item {state.ui.sidebarActive == 'upload'?'is-active':''}">
                <a class="sidebar-nav__link" onclick={openBox} data-menu="upload"><i class="sidebar-nav__icon fa fa-upload"></i> Upload</a>
            </li>
        </ul>
    </div>

    <script>
        const $ = require('jquery')
        const uiloader = require('../../scripts/uiloader.js')
        const store = this.opts.store
        const actions = require('../../scripts/actions/index.js')
        store.subscribe(function() {
            this.state = store.getState()
            this.update()
        }.bind(this))

        this.on('mount', function() {
            this.state = store.getState()

            this.box = riot.mount('div#grafy-sidebar-box', `grafy-${this.state.ui.sidebarActive}-box`, {
                store: store
            })

            this.update()
        })
        openBox(e) {

            let menu = e.currentTarget.dataset.menu
            store.dispatch(actions.ui.activateSidebar(menu))
            console.log(this.box)
            this.box && this.box[0].unmount(true)

            this.box = riot.mount('div#grafy-sidebar-box', `grafy-${menu}-box`, {
                store: store
            })

        }
    </script>
</grafy-sidebar-item>