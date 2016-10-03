<app-contentbox>

    <div class="contentbox-detail">
        <div class="row">
            <div class="col-lg-12">
                <div class="main-page-header clearfix">
                    <div class="breadcrumb">
                        <span> <a href="/contentbox"> Contentbox</a> <i if={opts.contentboxId} class="fa fa-angle-right"></i> <a if={opts.contentboxId} href="/contentbox/{opts.contentboxId}">{state.contentbox.activeItem.name}</a> </span>
                    </div>
                </div>
                <!-- /page-header -->
            </div>
        </div>


        <div class="row">
            <div class="col-lg-12">
                <div id="latest-feed-block" class="content-block">
                    <div class="page-header clearfix">
                        <h3 class="pull-left">
                            <span data-toggle="{state.contentbox.activeItem.id?tooltip:''}" data-placement="top" title="Click to edit" onkeydown={updateBoxOnEnter} onblur={updateBox} contenteditable={state.contentbox.activeItem.id}> {state.contentbox.activeItem.name}</span>                            <span if={state.contentbox.activeItem.id} class="badge">{formater.formatNumber(state.contentbox.activeItem.content.length)}</span>
                        </h3>

                        <div if={state.contentbox.activeItem.id} class="pull-right heading-btn">

                            <a data-toggle="tooltip" data-placement="top" title="Export" if={opts.contentboxId && state.contentbox.activeItem.content.length> 0} class="btn borderless-btn clearfix" href="#" onclick={exportContentBox}><i class="fa fa-download"></i> <span class="visible-lg pull-right">Export</span></a>

                            <a data-toggle="tooltip" data-placement="top" title="Import" if={opts.contentboxId} class="btn borderless-btn clearfix" href="#" onclick={openExcelFile}><i class="fa fa-upload"></i> <span class="visible-lg pull-right">Import</span></a>

                            <a data-toggle="tooltip" data-placement="top" title="Delete" if={opts.contentboxId} class="btn borderless-btn clearfix" href="#" onclick={deleteBox}><i class="fa fa-trash"></i> <span class="visible-lg pull-right">Delete</span></a>
                        </div>



                    </div>
                    <!-- /page-header -->
                    <div class="result-list cb-list">
                        <div if={state.contentbox.activeItem.content.length<1} class="no-result">
                            <i class="fa fa-frown-o"></i>
                            <p>There is no content in this Content Box.</p>
                        </div>
                        <div if={state.contentbox.activeItem.content.length> 0 && state.contentbox.activeItem.id} class="check-setting clearfix">
                            <div class="pull-left">
                                <a class="check-me" href="#" onclick={state.contentbox.checkAll?uncheckAll:checkAll}>
                                    <span if={state.contentbox.checkAll}><i class="fa fa-check-square"></i> Uncheck All</span>
                                    <span if={!state.contentbox.checkAll}><i class="fa fa-square-o"></i> Check All</span>
                                </a>

                            </div>

                            <div class="pull-right">
                                <div class="dropdown right-dropdown">
                                    <button class="btn borderless-btn" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        Action
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="dLabel">
                                        <li><a href="#" onclick={deleteSelectedContent}>Delete Selected</a></li>
                                        <li><a href="#" onclick={deleteAllContent}>Delete All</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <ul class="media-list">
                            <li each={value, key in state.contentbox.activeItem.content} class="media">

                                <div if={state.contentbox.activeItem.id} class="media-left">
                                    <span class="check ">
                                        <a onclick={value.isChecked?uncheckItem:checkItem} href="#" class="check-me {value.isChecked?'active':''}"><i class="fa fa-square-o"></i><i class="fa fa-check-square"></i></a>
                                    </span>
                                </div>
                                <div class="media-body">
                                    <div class="clearfix">
                                        <div class="pull-left">
                                            <a if={value.type=="picture" } class="thumb-over" href="#" onclick={showPreview} data-toggle="tooltip" data-placement="top" title="Click here to view this picture..">
                                                <span class="playme"><i class="fa fa-picture-o"></i> </span>
                                                <img class="media-object" src="{value.content}" alt="">
                                            </a>
                                            <a if={value.type=="template" } class="thumb-over" href="#" data-toggle="tooltip" data-placement="top" title="Click here to edit this template..">
                                                <span class="playme"><i class="fa fa-pencil"></i> </span>
                                                <img class="media-object" src="{scApi.host}{JSON.parse(value.content).thumb}" alt="">
                                            </a>
                                        </div>
                                        <div class="pull-left">
                                            <h4 if={value.type=="link" }><a href="{value.content}" target="_blank">{value.content}</a></h4>
                                            <p if={value.type!=="text" } data-toggle="{state.contentbox.activeItem.id?tooltip:''}" data-placement="top" title="Click to edit" onblur={updateDescription} contenteditable={state.contentbox.activeItem.id}>{!value.description?'click here to edit':value.description}</p>
                                            <p if={value.type=="text" } data-toggle="{state.contentbox.activeItem.id?tooltip:''}" data-placement="top" title="Click to edit" onblur={updateContent} contenteditable={state.contentbox.activeItem.id}>{value.content}</p>
                                        </div>
                                    </div>

                                </div>
                                <div class="media-right">
                                    <a if={state.contentbox.activeItem.id} href="#" onclick={deleteContent} class="btn trash-btn borderless-btn pull-right"><i class="fa fa-trash"></i></a>
                                    <a href="#" onclick={shareThis} class="btn share-btn borderless-btn pull-right"><i class="fa fa-share"></i></a>

                                </div>
                            </li>
                        </ul>
                    </div>
                    <!-- /cb-list -->
                </div>
            </div>
        </div>
    </div>
    <form id="form-excel-file" method="post" enctype="multipart/form-data">
        <input type="file" id="excel-file" class="file-input" form="form-excel-file" name="excelFile" onchange="{readExcelFile}" style="opacity:0; height:0px;width:0px;" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel">
    </form>
    <script>
        const $ = require('jquery')
        const store = this.opts.store
        const actions = require('../scripts/actions/index.js')
        const notification = require('../scripts/notification.js')
        const formater = require('../scripts/formater.js')
        const uiloader = require('../scripts/uiloader.js')
        const scApi = require('../scripts/api.js')
        const observables = require('../scripts/observables/index.js')
            //const XLSX = require('xlsx')

        store.subscribe(function() {
            this.state = store.getState()

            if (this.state.contentbox.isLoadingContent) {

                uiloader.blockEl()
            } else {

                uiloader.unblockEl()
            }
            this.update()
        }.bind(this))


        this.on('mount', function() {
            this.state = store.getState()
            this.formater = formater
            this.scApi = scApi
            let data = {}

            data.id = this.opts.contentboxId



            store.dispatch(actions.contentbox.loadContent(data))

            $(this.root).addClass('push250 detail-page')
            let sameHeight = $(this.root).outerHeight();
            $('div#slide-block').css('height', sameHeight + 'px')

            // this.trigger('init_masonry')

        })

        this.on('updated', function() {
            $('[data-toggle="tooltip"]').tooltip()
            let cblist = $('.cb-list.result-list .media').outerWidth()
            cblist = cblist - 200;
            $('.cb-list.result-list .media-list .media h4').css('width', cblist + 'px')

        })

        $(window).resize(function() {
            let cblist = $('.cb-list.result-list .media').outerWidth()
            cblist = cblist - 200;
            $('.cb-list.result-list .media-list .media h4').css('width', cblist + 'px')

        })

        deleteBox(e) {

            if (confirm('Are you sure want to delete this Content Box?')) {
                store.dispatch(actions.contentbox.deleteBox())
            }

        }


        updateBox(e) {

            if (e.currentTarget.innerText.trim().length < 1) {
                notification('Please input a name for this Content Box', 'error')
            } else if (e.currentTarget.innerText.length <= 50) {
                if (this.state.contentbox.activeItem.name !== e.currentTarget.innerText) {
                    store.dispatch(actions.contentbox.updateBox({
                        name: e.currentTarget.innerText
                    }))


                }

            } else {
                notification('The Content Box name exceeds the maximum of 50 characters', 'error')

            }
        }
        updateBoxOnEnter(e) {

            if (e.which == 13) {
                if (e.currentTarget.innerText.trim().length < 1) {
                    notification('Please input a name for this Content Box', 'error')
                } else if (e.currentTarget.innerText.length <= 50) {
                    if (this.state.contentbox.activeItem.name !== e.currentTarget.innerText) {
                        $(e.currentTarget).blur()


                    }


                } else {
                    notification('The Content Box name exceeds the maximum of 50 characters', 'error')

                }


                return false
            } else {

                return true
            }
        }



        updateDescription(e) {


            if (e.currentTarget.innerText !== 'click here to edit' && e.currentTarget.innerText !== e.item.value.description) {

                let data = {}
                data['id'] = e.item.value.id
                data['description'] = e.currentTarget.innerText
                data['mode'] = 'description'
                data['index'] = e.item.key
                store.dispatch(actions.contentbox.updateContent(data))
            }

        }

        updateContent(e) {


            if (e.currentTarget.innerText !== 'click here to edit' && e.currentTarget.innerText !== e.item.value.content) {

                let data = {}
                data['id'] = e.item.value.id
                data['content'] = e.currentTarget.innerText
                data['mode'] = 'content'
                data['index'] = e.item.key
                store.dispatch(actions.contentbox.updateContent(data))
            }

        }

        deleteContent(e) {

            if (confirm('Are you sure want to delete this content?')) {
                let data = {}
                data['id'] = e.item.value.id

                data['index'] = e.item.key
                store.dispatch(actions.contentbox.deleteContent(data))
            }
        }

        checkAll(e) {
            store.dispatch(actions.contentbox.checkAll(true))

        }

        uncheckAll(e) {

            store.dispatch(actions.contentbox.checkAll(false))
        }

        checkItem(e) {

            let data = {}
            data.check = true
            data.item = e.item

            store.dispatch(actions.contentbox.checkItem(data))

        }

        uncheckItem(e) {

            let data = {}
            data.check = false
            data.item = e.item

            store.dispatch(actions.contentbox.checkItem(data))

        }

        deleteAllContent(e) {

            store.dispatch(actions.contentbox.deleteAllContent())
        }

        deleteSelectedContent(e) {

            store.dispatch(actions.contentbox.deleteSelectedContent())

        }

        showPreview(e) {

            let preview = {
                value: e.item.value,
                key: 0
            }
            observables.preview.trigger('show_media_preview', {
                item: preview,
                mode: 'cb_picture',
                source: 'contentbox',
                length: 1
            })

        }
        shareThis(e) {

            let data = {}
            data.source = 'cb_' + e.item.value.type

            data.item = e.item

            observables.preview.trigger('open_share_dialog', data)
        }
        openExcelFile() {
            $('#excel-file').trigger('click')
        }

        readExcelFile(e) {
            if (this.beforeRead()) {

                //console.log('test')
                let f = $('#excel-file')[0].files[0]
                let reader = new FileReader();
                let name = f.name;
                reader.onload = function(e) {
                    let data = e.target.result;

                    let workbook = XLSX.read(data, {
                        type: 'binary'
                    });
                    let content = []
                        /* DO SOMETHING WITH workbook HERE */

                    let sheet_name_list = workbook.SheetNames;
                    sheet_name_list.forEach(function(y) { /* iterate through sheets */
                        let worksheet = workbook.Sheets[y];
                        ////console.log(worksheet)
                        try {
                            if (worksheet['A1'].v !== 'content' || worksheet['B1'].v !== 'description' || worksheet['C1'].v !== 'type') {

                                notification("Make sure that you chose an excel file with correct format! Please refer to the sample file.", "error")
                                    //console.log(worksheet)
                            } else {

                                //self.posts = self.posts.concat(XLSX.utils.sheet_to_row_object_array(worksheet))
                                content = XLSX.utils.sheet_to_row_object_array(worksheet)
                                console.log(content)

                            }

                        } catch (err) {

                            notification("Make sure that you chose an excel file with correct format! Please refer to the sample file.", "error")
                                //console.log(err)
                        }
                        if (content.length > 366) {
                            notification("You can't import Content Box  more than 366 items.", "error")
                            content = []
                        }



                    });
                    if (content.length > 0) {
                        store.dispatch(actions.contentbox.importContent(content))
                    }
                };
                reader.readAsBinaryString(f);
            }

        }

        beforeRead() {
            //check whether browser fully supports all File API
            if (window.File && window.FileReader && window.FileList && window.Blob) {
                if (!$('#excel-file').val()) //check empty input filed
                {
                    notification('You canceled upload dialog', 'success')
                    return false
                }
                let fsize = $('#excel-file')[0].files[0].size; //get file size
                let ftype = $('#excel-file')[0].files[0].type; // get file type
                //allow only valid image file types
                switch (ftype) {
                    case 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet':
                    case 'application/vnd.ms-excel':
                    case '':
                        break;
                    default:
                        notification(ftype + ' Unsupported file type!', 'error')
                        return false
                }
                //Allowed file size is less than 1 MB (1048576)
                if (fsize > 10485760) {

                    notification(fsize + ' Too big Content Box file! Please reduce the size of your photo using an image editor.', 'error')

                    return false
                }



                return true
            } else {

                notification('Please upgrade your browser, because your current browser lacks some new features we need!', 'error')

                return false;
            }
        }

        function Workbook() {
            if (!(this instanceof Workbook)) return new Workbook();
            this.SheetNames = [];
            this.Sheets = {};
        }
        exportContentBox(e) {
            var cbReadyExport = [
                ['content', 'description', 'type']
            ]

            this.state.contentbox.activeItem.content.forEach(function(element, index, array) {

                    cbReadyExport.push([element.content, element.description, element.type])

                })
                //console.log(self.postsReadyExport)
            var wb = new Workbook(),
                ws = this.sheet_from_array_of_arrays(cbReadyExport);

            var ws_name = this.state.contentbox.activeItem.name
                /* add worksheet to workbook */
            wb.SheetNames.push(ws_name);
            wb.Sheets[ws_name] = ws;
            var wbout = XLSX.write(wb, {
                bookType: 'xlsx',
                bookSST: true,
                type: 'binary'
            });



            /* the saveAs call downloads a file on the local machine */
            saveAs(new Blob([this.s2ab(wbout)], {
                type: "application/octet-stream"
            }), ws_name + ".xlsx")
        }

        s2ab(s) {
            var buf = new ArrayBuffer(s.length);
            var view = new Uint8Array(buf);
            for (var i = 0; i != s.length; ++i) view[i] = s.charCodeAt(i) & 0xFF;
            return buf;
        }


        datenum(v, date1904) {
            if (date1904) v += 1462;
            var epoch = Date.parse(v);
            return (epoch - new Date(Date.UTC(1899, 11, 30))) / (24 * 60 * 60 * 1000);
        }

        sheet_from_array_of_arrays(data, opts) {
            var ws = {};
            var range = {
                s: {
                    c: 10000000,
                    r: 10000000
                },
                e: {
                    c: 0,
                    r: 0
                }
            };
            for (var R = 0; R != data.length; ++R) {
                for (var C = 0; C != data[R].length; ++C) {
                    if (range.s.r > R) range.s.r = R;
                    if (range.s.c > C) range.s.c = C;
                    if (range.e.r < R) range.e.r = R;
                    if (range.e.c < C) range.e.c = C;
                    var cell = {
                        v: data[R][C]
                    };
                    if (cell.v == null) continue;
                    var cell_ref = XLSX.utils.encode_cell({
                        c: C,
                        r: R
                    });

                    if (typeof cell.v === 'number') cell.t = 'n';
                    else if (typeof cell.v === 'boolean') cell.t = 'b';
                    else if (cell.v instanceof Date) {
                        cell.t = 'n';
                        cell.z = XLSX.SSF._table[14];
                        cell.v = this.datenum(cell.v);
                    } else cell.t = 's';

                    ws[cell_ref] = cell;
                }
            }
            if (range.s.c < 10000000) ws['!ref'] = XLSX.utils.encode_range(range);
            return ws;
        }
    </script>
</app-contentbox>