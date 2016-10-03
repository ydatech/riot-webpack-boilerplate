<app-sidebar>

	<div class="sidebar-nav" aria-expanded="false">
		<ul class="nav clearfix" id="left-menu">
			<li class={active : state.ui.sidebarActive=='keyword' }>
				<a onclick={goTo} data-menu="keyword" href="#"><i class="fa fa-search fa-fw"></i> <span class="hidden-xs">Keyword</span></a>
				<a if={state.ui.sidebarActive=='keyword' } onclick={hideShowBlock} href="#" class="toggle toggle-sidebar"><i class="fa {btnActive?'fa-toggle-on':'fa-toggle-off'}"></i></a>
			</li>
			<li class={active : state.ui.sidebarActive=='topcontent' }>
				<a onclick={goTo} data-menu="topcontent" href="#"><i class="fa fa-newspaper-o fa-fw"></i> <span class="hidden-xs">Top Content</span></a>
				<a if={state.ui.sidebarActive=='topcontent' } onclick={hideShowBlock} href="#" class="toggle toggle-sidebar"><i class="fa {btnActive?'fa-toggle-on':'fa-toggle-off'}"></i></a>
			</li>
			<li class={active : state.ui.sidebarActive=='feed' }>
				<a onclick={goTo} data-menu="feed" href="#"><i class="fa fa-rss fa-fw"></i> <span class="hidden-xs">Feeds</span></a>
				<a if={state.ui.sidebarActive=='feed' } onclick={hideShowBlock} href="#" class="toggle toggle-sidebar"><i class="fa {btnActive?'fa-toggle-on':'fa-toggle-off'}"></i></a>
			</li>
			<li class={active : state.ui.sidebarActive=='contentbox' }>
				<a onclick={goTo} data-menu="contentbox" href="#"><i class="fa fa-cloud-download fa-fw"></i> <span class="hidden-xs">Content Box</span></a>
				<a if={state.ui.sidebarActive=='contentbox' } onclick={hideShowBlock} href="#" class="toggle toggle-sidebar"><i class="fa {btnActive?'fa-toggle-on':'fa-toggle-off'}"></i></a>
			</li>
			<li class={active : state.ui.sidebarActive=='template' }>
				<a onclick={goTo} data-menu="template" href="#"><i class="fa fa-paint-brush fa-fw"></i> <span class="hidden-xs">Templates</span></a>
				<a if={state.ui.sidebarActive=='template' } onclick={hideShowBlock} href="#" class="toggle toggle-sidebar"><i class="fa {btnActive?'fa-toggle-on':'fa-toggle-off'}"></i></a>
			</li>
		</ul>
	</div>

	<script>
		const $ = require('jquery')
		const uiloader = require('../scripts/uiloader.js')
		const store = this.opts.store

		store.subscribe(function() {
			this.state = store.getState()
			this.update()
		}.bind(this))

		this.on('mount', function() {
			this.btnActive = true
		})

		hideShowBlock(e) {
			$('#main').toggleClass('push250')
			$('#slide-block').toggleClass('active')
			if (this.btnActive) {
				this.btnActive = false
			} else {
				this.btnActive = true
			}
		}
		showBlock(e) {

		}
		goTo(e) {

			riot.route(e.currentTarget.dataset.menu)

		}
	</script>
</app-sidebar>