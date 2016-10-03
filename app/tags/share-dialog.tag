<app-share-dialog>

    <iframe if={url} src="{url}" id="sociocaster-share-overlay" style="background-image: none; border: none !important; height: 100% !important; width: 100% !important; position: fixed !important; z-index: 2147483646 !important; top: 0px !important; left: 0px !important; display: block !important; max-width: 100% !important; max-height: 100% !important; padding: 0px !important; background-attachment: initial !important; background-color: rgba(245, 245, 245, 0.741176) !important; background-size: 40px !important; background-origin: initial !important; background-clip: initial !important; background-position: 50% 50% !important; background-repeat: no-repeat !important;">
    </iframe>

    <script>
        const $ = require('jquery')
        const observables = require('../scripts/observables/index.js')
        const scApi = require('../scripts/api.js')
            //https://sociocaster.com/external?open=extension&amp;link=http%3A%2F%2Fnews.detik.com%2Fberita%2F3307507%2Fketika-diam-jadi-jawaban-bagi-pns-pengadilan-pemilik-19-mobil&amp;message=Ketika%20Diam%20Jadi%20Jawaban%20Bagi%20PNS%20Pengadilan%20Pemilik%2019%20Mobil
        this.url = false

        observables.preview.on('open_share_dialog', function(data) {
            this.item = data.item
            this.source = data.source

            console.log(data)
            let params;
            switch (this.source) {
                case 'youtube':

                    params = {
                            open: 'extension',
                            link: 'https://youtube.com/watch?v=' + this.item.value.id,
                            message: this.item.value.title
                        }
                        // let decodedParams = decodeURIComponent($.param(params, true))
                    this.url = `${scApi.host}/external?open=extension&link=${params.link}&message=${params.message}`

                    break;
                case 'flickr':
                    params = {
                        open: 'extension',
                        message: this.item.value.title,
                        picture: this.item.value.url_big
                    }

                    this.url = `${scApi.host}/external?open=extension&picture=${params.picture}&message=${params.message}`

                    break;
                case 'twitter':
                    params = {
                        open: 'extension',
                        message: this.item.value.text
                    }
                    this.url = `${scApi.host}/external?open=extension&message=${params.message}`
                    break;
                case 'feed':

                    params = {
                            open: 'extension',
                            link: this.item.value.link,
                            message: this.item.value.title
                        }
                        // let decodedParams = decodeURIComponent($.param(params, true))
                    this.url = `${scApi.host}/external?open=extension&link=${params.link}&message=${params.message}`

                    break;
                case 'topcontent_link':
                    params = {
                            open: 'extension',
                            link: this.item.value.link,
                            message: this.item.value.link_name
                        }
                        // let decodedParams = decodeURIComponent($.param(params, true))
                    this.url = `${scApi.host}/external?open=extension&link=${params.link}&message=${params.message}`
                    break;
                case 'topcontent_photo':
                case 'topcontent_picture':
                    params = {
                        open: 'extension',
                        message: '',
                        picture: encodeURIComponent(this.item.value.picture)
                    }

                    this.url = `${scApi.host}/external?open=extension&picture=${params.picture}&message=${params.message}`
                    break;
                case 'cb_picture':
                    params = {
                        open: 'extension',
                        message: this.item.value.description,
                        picture: this.item.value.content

                    }
                    this.url = `${scApi.host}/external?open=extension&picture=${params.picture}&message=${params.message}`
                    break;
                case 'cb_template':
                    params = {
                        open: 'extension',
                        message: this.item.value.description,
                        picture: JSON.parse(this.item.value.content).picture

                    }
                    this.url = `${scApi.host}/external?open=extension&picture=${params.picture}&message=${params.message}`
                    break;
                case 'cb_link':
                    params = {
                            open: 'extension',
                            link: this.item.value.content,
                            message: this.item.value.description,
                        }
                        // let decodedParams = decodeURIComponent($.param(params, true))
                    this.url = `${scApi.host}/external?open=extension&link=${params.link}&message=${params.message}`
                    break;
                case 'cb_text':
                    params = {
                        open: 'extension',
                        message: this.item.value.content
                    }
                    this.url = `${scApi.host}/external?open=extension&message=${params.message}`
                    break;


            }

            console.log(this.url)
            this.update()

        }.bind(this))



        window.addEventListener("message", function(event) {
            var origin = event.origin || event.originalEvent.origin // For Chrome, the origin property is in the event.originalEvent object.

            if (origin !== scApi.host)
                return false

            if (event.data == 'sociocaster_post_creator_closed') {

                this.url = false
                this.update()
            }



        }.bind(this), false)
    </script>
</app-share-dialog>