<raw>
    <div></div>

    <script>
        this.on('mount', function() {
            this.root.childNodes[0].innerHTML = this.opts.content
        }.bind(this))

        this.on('update', function() {
            this.root.childNodes[0].innerHTML = this.opts.content;
        }.bind(this))
    </script>
</raw>