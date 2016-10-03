<app-navbar>

	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse" aria-expanded="false">
	                    <span class="sr-only">Toggle navigation</span>
	                    <span class="icon-bar"></span>
	                    <span class="icon-bar"></span>
	                    <span class="icon-bar"></span>
	                </button>
		<a class="navbar-brand" href="/"><img src="{opts.logo}" alt="Sociocaster" /></a>
	</div>
	<div class="navbar-collapse collapse" aria-expanded="false">
		<ul class="nav navbar-nav" id="left-menu">
			<li>
				<a href="#"><i class="fa fa-paper-plane fa-fw"></i> Post</a>
			</li>
			<li class="active">
				<a href="/"><i class="fa fa-newspaper-o fa-fw"></i> Content</a>
			</li>
			<li>
				<a href="#"><i class="fa fa-wrench fa-fw"></i> Add-ons</a>
			</li>
			<li>
				<a href="#"><i class="fa fa-bar-chart fa-fw"></i> Analytics</a>
			</li>
		</ul>
		<ul class="nav navbar-top-links navbar-right">
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="#">
					<img src="{state.auth.user.avatar}" alt="{state.auth.user.username}"> <i class="fa fa-caret-down"></i>
				</a>
				<ul class="dropdown-menu dropdown-user">
					<li>
						<a href="/panel/setting">
							<i class="ace-icon fa fa-cog fa-fw"></i> Settings
						</a>
					</li>

					<li>
						<a href="/posts/connect">
							<i class="ace-icon fa fa-users fa-fw"></i> Manage Accounts
						</a>
					</li>
					<li>
						<a href="/panel/accounts">
							<i class="ace-icon fa fa-sitemap fa-fw"></i> Manage Organization &amp; Team Members
						</a>
					</li>
					<li>
						<a href="/tutorial">
							<i class="ace-icon fa fa-youtube-play fa-fw"></i> Tutorial
						</a>
					</li>
					<li>
						<a href="/support">
							<i class="ace-icon fa fa-phone fa-fw"></i> Support
						</a>
					</li>

					<li>
						<a href="/panel/memberarea">
							<i class="ace-icon fa fa-credit-card fa-fw"></i> Member Area
						</a>
					</li>
					<li class="divider"></li>
					<li><a href="/app/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
					</li>
				</ul>
			</li>
		</ul>
		<ul class="nav navbar-top-links navbar-right">
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="#">
					<i class="fa fa-bell fa-fw"></i> <span if={state.navbar.notification._meta.unreadCount> 0} class="badge badge-notification">{state.navbar.notifications._meta.unreadCount}</span>
				</a>
				<ul class="dropdown-menu dropdown-user">
					<li each={value,key in state.navbar.notification.items}>
						<a href="#"><i class="fa fa-user fa-fw"></i> {value.body}</a>
					</li>
				</ul>
			</li>
		</ul>
		<ul class="nav navbar-top-links navbar-right">
			<li>
				<a class="dropdown-toggle" data-toggle="dropdown" href="/inbox">
					<i class="fa fa-envelope fa-fw"></i>
				</a>

			</li>
		</ul>
	</div>
	<!-- /main-nav -->
	<script>
		const store = this.opts.store
		const actions = require('../scripts/actions/index.js')

		this.on('mount', function() {

			this.state = store.getState()

			store.dispatch(actions.navbar.loadNotif())

			this.update()
		})

		store.subscribe(function() {

			this.state = store.getState()
			this.update()

		}.bind(this))
	</script>

</app-navbar>