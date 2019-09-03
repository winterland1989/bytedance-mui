m = require 'mithril'
s = require 'mss-js'
buildIcon = require 'mmsvg/google/msvg/action/build'
delIcon = require 'mmsvg/google/msvg/action/delete'
infoIcon = require 'mmsvg/google/msvg/action/info-outline'
msgIcon = require 'mmsvg/google/msvg/communication/message'

List = require '../List'
Button = require '../Button'
ButtonThemed = require '../ButtonThemed'
ButtonDashed = require '../ButtonDashed'
ButtonWire = require '../ButtonWire'
GroupButton = require '../GroupButton'
DatePicker = require '../DatePicker'
DateRange = require '../DateRange'
Switch = require '../Switch'
CheckBox  =require '../CheckBox'
DropDown = require '../Dropdown'
Modal = require '../Modal'
TextInput = require '../TextInput'
TagInput  =require '../TagInput'
TextArea = require '../TextArea'
Collaspe = require '../Collaspe'
Notify = require '../Notify'
Table = require '../Table'

u = require '../utils'

class Demo
    constructor: ->
        @demoLists = [
            new List
                itemArray: ['Foo', 'Bar', 'Qux']
                onSelect: (i) =>
                    @demoNotify1.show(msgIcon, i)
            new List
                itemArray: ['Foo', 'Bar', 'Qux', 'Foo', 'Bar', 'Qux', 'Foo', 'Bar', 'Qux']
                onSelect: (i) =>
                    @demoNotify1.show(msgIcon, i)
            new List
                itemArray: ['Foo', 'Bar', 'Qux', 'Foo', 'Bar', 'Qux', 'Foo', 'Bar', 'Qux']
                size: 'S'
                onSelect: (i) =>
                    @demoNotify1.show(msgIcon, i)
            new List
                itemArray: ['Foo', 'Bar', 'Qux', 'Foo', 'Bar', 'Qux', 'Foo', 'Bar', 'Qux']
                searchPlaceHolder: 'search...'
                size: 'XS'
                onSelect: (i) =>
                    @demoNotify1.show(msgIcon, i)
        ]
        @demoListDoc = new Collaspe
            titleArray: ['List document']
            widgetArray: [
                m 'textarea', readonly: true,
                    """
                    List = require 'mui-js/List'

                    demoList = new List
                        itemArray: ['Foo', 'Bar', 'Qux']
                    """
            ]
        @demoCheckBoxes = [
            new CheckBox
                checked: true
            new CheckBox
                label: 'bar'
                checked: false
            new CheckBox
                disabled: true
                checked: true
            new CheckBox
                disabled: true
                checked: false
            new CheckBox
                checked: true
                partial: true
            new CheckBox
                checked: true
                disabled: true
                partial: true
        ]
        @demoCheckBoxDoc = new Collaspe
            titleArray: ['CheckBox document']
            widgetArray: [
                m 'textarea', readonly: true,
                    """
                    CheckBox = require 'mui-js/CheckBox'

                    demoCheckBox = new CheckBox
                        checked: true

                    ###
                        checked = true     # Boolean
                        disabled = false       # Boolean
                        partial = false        # Boolean
                        label = ''             # String | mithril view
                        onToggle = ( -> )   # (Boolean) -> a
                    ###
                    """
            ]

        @demoButtons = [
            new Button
                label: 'Foo'
            new Button
                label: [buildIcon, 'Build']
            new Button
                label: ['Delete', delIcon]
            new Button
                label: 'Disabled'
                disabled: true
            new Button
                label: 'Foo'
                size: 'XS'
            new Button
                label: 'Foo'
                width: 'PADDING'
            new Button
                label: 'Foo'
                width: '100%'
            new ButtonThemed
                label: 'Foo'
            new ButtonDashed
                label: 'Foo'
            new ButtonWire
                label: 'Foo'
        ]

        @demoButton6 = new Button
            label: 'Foo'
            size: 'XL'

        @demoButton7 = new Button
            label: 'Foo'
            width: 'PADDING'

        @demoButtonDoc = new Collaspe
            titleArray: ['Button document']
            widgetArray: [
                m 'textarea', readonly: true,
                    """
                    Button = require 'mui-js/Button'
                    buildIcon = require 'mmsvg/google/msvg/action/build'
                    u = require 'mui-js/utils'

                    demoButton = new Button
                        label: [buildIcon, 'Build']

                    ###
                        label                      # String | mithril view | [mithril views]
                        disabled = false           # Boolean (default = false)
                        onClick = u.noOp           # (data :: String) -> a (default = ->)
                        data = ''                  # String (default = '')
                        size = 'M'                 # size: 'XS' | 'S' | 'M' | 'L' | 'XL'         (default = 'M')
                        width ='FIXED'             # width: 'FIXED' | 'PADDING' | '100%', '123px'...  (default = '100px')
                    ###
                    """
            ]

        @demoBtnGroupDoc = new Collaspe
            titleArray: ['GroupButton document']
            widgetArray: [
                m 'textarea', readonly: true,
                    """
                    GroupButton = require 'mui-js/GroupButton'

                    demoBtnGroup = new GroupButton
                        textArray: ['foo', 'bar', 'qux']
                        onChange: (enabledArray) => ...

                    ###
                        textArray         # [String]
                        enabledIndexArray # [Int]
                        multiSelection    # Boolean
                        onChange = ->     # ([Int]) -> a
                    ###
                    """
            ]


        @demoBtnGroups = [
            new GroupButton
                textArray: ['foo', 'bar', 'qux']
                size: 'S'
                onSelect: (enabledArray) =>
                    @demoNotify1.show(msgIcon, JSON.stringify enabledArray)

            new GroupButton
                textArray: ['foo', 'bar', 'qux']
                onSelect: (enabledArray) =>
                    @demoNotify1.show(msgIcon, JSON.stringify enabledArray)

            new GroupButton
                textArray: ['你好', '再见', '好好学习，天天向上']
                multi: false
                onSelect: (enabledArray) =>
                    @demoNotify1.show(msgIcon, JSON.stringify enabledArray)

            new GroupButton
                textArray: ['Selected', 'Selected(disabled)', 'Unselected', 'Unselected(disabled)']
                stateArray: [true, true, false, false]
                disabledArray: [false, true, false, true]
                onSelect: (enabledArray) =>
                    @demoNotify1.show(msgIcon, JSON.stringify enabledArray)

            new GroupButton
                textArray: ['Selected', 'Selected(disabled)', 'Unselected', 'Unselected(disabled)']
                stateArray: [true, true, false, false]
                disabledArray: [false, true, false, true]
                multi: false
                onSelect: (enabledArray) =>
                    @demoNotify1.show(msgIcon, JSON.stringify enabledArray)
        ]

        @demoDatePickers = [
            new DatePicker
                date: null
            new DatePicker
                date: new Date()
                ifDateAvailable: (date) ->
                    date >= new Date(Date.now() - 10*24*3600*1000)
            new DatePicker
                date: new Date()
            new DatePicker
                date: new Date()
                highlightStartDate: new Date(Date.now() - 2*24*3600*1000)
                highlightEndDate: new Date(Date.now() + 2*24*3600*1000)
        ]

        @demoDatePickerDoc = new Collaspe
            titleArray: ['DatePicker document']
            widgetArray: [
                m 'textarea', readonly: true,
                    """
                    # modify i18n before use
                    DatePicker = require 'mui-js/DatePicker'

                    demoDatePicker2 = new DatePicker
                        date: new Date()
                        selectTime: true

                    ###
                        date                         # Date
                        selectTime                   # Boolean
                        ifDateAvailable = (-> true)  # (Date) -> Boolean
                        onSelect = (->)              # (Date) -> a
                    ###
                    """
            ]

        @demoDateRanges = [
            new DateRange
                startDate: new Date(Date.now() - 3*24*3600*1000)
                endDate: new Date()
        ]

        @demoDateRangeDoc = new Collaspe
            titleArray: ['DateRange document']
            widgetArray: [
                m 'textarea', readonly: true,
                    """
                    # modify i18n before use
                    DateRange = require 'mui-js/DateRange'

                    demoDateRange2 = new DateRange
                        date: new Date()
                        selectTime: true

                    ###
                        date                         # Date
                        selectTime                   # Boolean
                        ifDateAvailable = (-> true)  # (Date) -> Boolean
                        onSelect = (->)              # (Date) -> a
                    ###
                    """
            ]

        @demoSwitch = new Switch
            enable: true

        @demoSwitchDoc = new Collaspe
            titleArray: ['Switch document']
            widgetArray: [
                m 'textarea', readonly: true,
                    """
                    Switch = require 'mui-js/Switch'

                    demoSwitch = new Switch
                        enable: true

                    ###
                        enable = true       # Boolean
                        onToggle = ( -> )   # (Boolean) -> a
                    ###
                    """
            ]


        @demoDropDowns = [
            new DropDown
                itemArray: ['foo', 'bar', '~~~']
                currentIndex: 2

            new DropDown
                itemArray: ['foo', 'bar', '~~~']
                disabled: true
                size: 'S'
                placeholder: 'please select a foo'

            new DropDown
                itemArray: ['foo', 'bar', '~~~']
                size: 'S'
                placeholder: 'please select a foo'

            new DropDown
                itemArray: (i.toString() for i in [1..100])
                size: 'XS'
                currentIndex: 20

            new DropDown
                itemArray: (i.toString() for i in [1..100])
                size: 'XS'
                searchPlaceHolder: 'enter digits...'
        ]

        @demoDropDownDoc = new Collaspe
            titleArray: ['DropDown document']
            widgetArray: [
                m 'textarea', readonly: true,
                    """
                    DropDown = require 'mui-js/Dropdown'

                    demoDropDown3 = new DropDown
                        itemArray: (i.toString() for i in [1..100])
                        currentIndex: 20

                    ###
                        itemArray               # [String]
                        currentIndex            # Int | Undefined
                        placeholder  = ''       # String
                        onSelect = (->)         # (String, Int) -> ...
                        ifAvailable = (-> true) # (String, Int) -> ture | false
                        allowEmptySelect = true # Bool
                    ###
                    """
            ]


        @demoModal1 = new Modal
            widget: view: ->
                m 'h2'
                ,
                    style:
                        width: '200px'
                        margin: '0 auto'
                        background: '#fff'
                ,'Close anywhere  else to close'

        @demoModal2 = new Modal
            clickToHide: false
            escToHide: false

        @demoModalOpenBtn1 = new Button
            text: 'Open a modal'
            onClick: @demoModal1.show

        @demoModalOpenBtn2 = new Button
            text: 'Open a modal'
            onClick: @demoModal2.show

        @demoModalCloseBtn = new Button
            text: 'Hide this modal'
            onClick: @demoModal2.hide

        @demoModal2.widget = @demoModalCloseBtn

        @demoModalDoc = new Collaspe
            titleArray: ['Modal document']
            widgetArray: [
                m 'textarea', readonly: true,
                    """
                    Modal = require 'mui-js/Modal'
                    # make sure widget inside is a block element

                    demoModal1 = new Modal
                        clickToHide: true
                        widget: view: ->
                            m 'h2'
                            ,
                                style:
                                    width: '200px'
                                    margin: '0 auto'
                                    background: '#fff'
                            ,'Close anywhere  else to close'

                    ###
                        widget                 # mithril view
                        clickToHide = true     # Boolean
                        escToHide = true       # Boolean
                        onHide = ( -> )        # () -> a
                    ###
                    """
            ]

        @demoTextInputs = [
            new TextInput
                size: 'XS'
                placeholder: 'type something...'
                onPaste: (s) => @demoNotify1.show(msgIcon, s)
            new TextInput
                size: 'S'
                placeholder: 'type something...'
            new TextInput
                placeholder: 'type something...'
            new TextInput
                size: 'L'
                placeholder: 'type something...'
            new TextInput
                size: 'XL'
                placeholder: 'type something...'
            new TextInput
                placeholder: '请输入密码'
                password: true
            new TextInput
                placeholder: '请输入出价'
                unit: '元'
            new TextInput
                prefix : 'http://'
                placeholder: 'bytedance'
                suffix: '.com'
            new TextInput
                disabled: true
                prefix : 'http://'
                placeholder: 'bytedance'
                suffix: '.com'
            new TextInput
                error: true
                prefix : 'http://'
                placeholder: 'bytedance'
                suffix: '.com'
        ]

        @demoTextInputDoc = new Collaspe
            titleArray: ['TextInput document']
            widgetArray: [
                m 'textarea', readonly: true,
                    """
                    TextInput = require 'mui-js/TextInput'

                    demoTextInput = new TextInput
                        onChange: (str) ->
                            if str != 'ya!'
                                new Error 'please input "ya!"'

                    ###
                        @content = ''           # String
                        @disabled = false       # Boolean
                        @placeholder = ''       # String
                        @onPaste = u.noOp       # (String) -> a | Error
                                                # triggered on Paste
                        @onChange = u.noOp      # (String) -> a | Error
                                                # triggered on Blur
                        @onEnter = u.noOp       # (String) -> a | Error
                                                # triggered when user release Enter
                        @onKeyup  = u.noOp      # (String) -> a | Error
                                                # triggered when user release key
                        @onClick = u.noOp       # () -> a
                                                # triggered when user click the input
                    ###
                    """
            ]

        @demoTagInputDoc = new Collaspe
            titleArray: ['TagInput document']
            widgetArray: [
                m 'textarea', readonly: true,
                    """
                    TagInput = require 'mui-js/TagInput'

                    @demoTagInput = new TagInput
                        tagList: ['foo', 'bar', 'qux']

                    ###
                        @tagList = []         # List of String
                        placeholder = ''      # String, placeholder of tag input
                        @separators = ' ,，'     # String, list of separators which will separate tags onkeyup
                        @onAdd = u.noOp       # (String) -> a, triggered on tag adding
                        @onDel = u.noOp       # (Int) -> a, triggered on tag deleting
                        @maxTagNum = Number.MAX_SAFE_INTEGER  # Int, limit the max tag user can input
                    ###
                    """
            ]

        @demoTagInput = new TagInput
            tagList: ['foo', 'bar', 'qux']

        @demoTextArea = new TextArea
            placeholder: 'type digits and enter!'
            onChange: (str) ->
                unless (/^\d+$/).test str
                    new Error 'please input some digits'

        @demoTextArea2 = new TextArea
            placeholder: 'this textarea allow tab key'
            allowTab: true

        @demoTextAreaDoc = new Collaspe
            titleArray: ['TextArea document']
            widgetArray: [
                m 'textarea', readonly: true,
                    """
                    TextArea = require 'mui-js/TextArea'

                    demoTextArea = new TextArea
                        onChange: (str) ->
                            if str != 'ya!'
                                new Error 'please input "ya!"'

                    ###
                        content = ''           # String
                        disabled = false       # Boolean
                        placeholder = ''       # String
                        onChange = u.noOp      # (String) -> a | Error
                                               # triggered on Blur or user stroke Enter
                        onKeyup  = u.noOp      # (String) -> a | Error
                                               # triggered when user stroke non-Enters
                        resize = 'none'        # none | both | horizontal | vertical
                                               # textarea resize attribute
                        rows = 5               # Number
                                               # an easier way to control height instead of inject MSS
                    ###
                    """
            ]

        @demoTableViewColMap =
            name: '名称'
            age: '年龄'
            salary: '工资'

        @demoTableViewData =
            [ {name: 'Joe', age: 24, salary: 10000}
            , {name: 'Kia', age: 13, salary: 20000}
            , {name: 'Lee', age: 14, salary: 40000}
            ]
        @demoTables = [
            new Table
                columns: [
                    {key: 'foo', title: 'FOO'}
                    {key: 'bar', title: 'BAR'}
                    {key: 'qux', title: 'QUX QUX', width: '50px'}
                ]
                data: [
                    {foo: 1, bar: 2, qux: 3}
                    {foo: 1, bar: 2, qux: 3}
                    {foo: 1, bar: 2, qux: 3}
                ]
                striped: true
            new Table
                columns: [
                    {key: 'foo', title: 'FOO'}
                    {key: 'bar', title: 'BAR'}
                    {key: 'qux', title: 'QUX'}
                ]
                data: [
                    {foo: 1, bar: 2, qux: 3}
                    {foo: 1, bar: 2, qux: 3}
                    {foo: 1, bar: 2, qux: 3}
                ]
                borderType: 'HORIZONTAL'
            new Table
                columns: [
                    {key: 'foo', minWidth: '184px', title: 'FOO', fixed: 'LEFT'}
                    {key: 'bar', minWidth: '184px', title: 'BAR'}
                    {key: 'bar', minWidth: '184px', title: 'BAR'}
                    {key: 'bar', minWidth: '184px', title: 'BAR'}
                    {key: 'qux', minWidth: '184px', title: 'QUX', fixed: 'RIGHT'}
                ]
                data: [
                    {foo: 1, bar: 2, qux: 3}
                    {foo: 1, bar: 2, qux: 3}
                    {foo: 1, bar: 2, qux: 3}
                ]
                mainWidth: '300px'
                mainScrollWidth: '200px'
        ]

        @demoTableViewDoc = new Collaspe
            titleArray: ['tableView document']
            widgetArray: [
                m 'textarea', readonly: true,
                    """
                    tableView = require 'mui-js/tableView'

                    demoTableViewColMap =
                        name: '名称'
                        age: '年龄'
                        salary: '工资'

                    demoTableViewData =
                        [ {name: 'Joe', age: 24, salary: 10000}
                        , {name: 'Kia', age: 13, salary: 20000}
                        , {name: 'Lee', age: 14, salary: 40000}
                        ]

                    tableView(demoTableViewColMap, demoTableViewData)
                    ###
                        colMap                 # HashMap
                                               # map key to column label
                        data                   # Array of HashMap
                                               # array of table data
                        verticalHeader = false # show header at left
                    ###
                    """
            ]

        @demoCollaspes = [
            new Collaspe
                titleArray: ['Hello', 'Byte']
                stateArray: [false, false]
                widgetArray: [ (m 'span', 'hello world') , (m 'span', 'bye world') ]

            new Collaspe
                titleArray: ['Hello', 'Byte']
                stateArray: [true, true]
                autoCollaspe: false
                borderType: 'HORIZONTAL'
                widgetArray: [ (m 'span', 'hello world') , (m 'span', 'bye world') ]

            new Collaspe
                titleArray: ['Hello', 'Byte']
                stateArray: [false, true]
                borderType: 'NONE'
                iconType: 'LEFT'
                widgetArray: [ (m 'span', 'hello world') , (m 'span', 'bye world') ]
        ]

        @demoCollaspeDoc = new Collaspe
            titleArray: ['Collaspe document']
            widgetArray: [
                m 'textarea', readonly: true,
                    """
                    Collaspe = require 'mui-js/Collaspe'

                    demoCollaspe = new Collaspe
                        titleArray: ['Hello', 'Byte']
                        stateArray: [1]
                        autoCollaspe: true
                        widgetArray: [
                            view: ->
                                m 'span', 'hello world'
                        ,
                            view: ->
                                m 'span', 'bye world'
                        ]

                    ###
                        titleArray                # [String | mithril widget]
                        stateArray                # [Int]
                        widgetArray               # [mithril widget]
                        autoCollaspe = true       # Boolean
                        iconType = 'RIGHT'        # 'RIGHT' | 'LEFT' | 'NONE'
                        borderType = 'ALL'        # 'ALL' | 'HORIZONTAL' | 'NONE' (default = 'ALL')
                        onExpand   = (->)         # Int -> a
                        onCollaspe = (->)         # Int -> a
                    ###
                    """
            ]

        @demoNotify1 = new Notify {}

        @demoNotifyOpenBtn1 = new Button
            text: 'Open a notify'
            onClick: => @demoNotify1.show(msgIcon, 'this is a notify')

        @demoNotifyOpenBtn1D = new Button
            text: 'Debounce'
            onClick: u.debounce(
                => @demoNotify1.show(msgIcon, 'notify per 1 seconds')
            ,   1000)

        @demoNotifyOpenBtn1D2 = new Button
            text: 'Debounce leading'
            onClick: u.debounce(
                => @demoNotify1.show(msgIcon, 'notify per 1 seconds')
            ,   1000
            ,   true)

        @demoNotify2 = new Notify
            onClick: ({foo}) => alert foo

        @demoNotifyOpenBtn2 = new Button
            text: 'Open a notify'
            onClick: => @demoNotify2.show(msgIcon, 'click me', foo: 'bar')

        @demoNotifyDoc = new Collaspe
            titleArray: ['Notify document']
            widgetArray: [
                m 'textarea', readonly: true,
                    """
                    Notify = require 'mui-js/Notify'

                    demoNotify1 = new Notify {}

                    demoNotifyOpenBtn1 = new Button
                       text: 'Open a notify'
                       onClick: => @demoNotify1.show(msgIcon, 'this is a notify')

                    demoNotify2 = new Notify
                       onClick: ({foo}) => alert foo

                    demoNotifyOpenBtn2 = new Button
                       text: 'Open a notify'
                        onClick: => @demoNotify2.show(msgIcon, 'click me', foo: 'bar')

                    ###
                        duration = 3000        # Int
                        onClick = ( -> )       # data -> a
                        show                   # (icon :: mithril svg, content :: String, data :: HashMap) -> undefined
                    ###
                    """
            ]

        @demoSpinnerDoc = new Collaspe
            titleArray: ['Spinner document']
            widgetArray: [
                m 'textarea', readonly: true,
                    """
                    u = require '../utils'
                    style = require '../style'

                    # directly put this into view
                    u.spinner style.main[4]

                    ###
                    utils.spinner(color, size = '1em', interval = '1s')
                    ###
                    """
            ]

    view: -> [

        m 'ul.Demo',


            m 'li', @demoListDoc.view()
            for l in @demoLists then m 'li', l.view()

            m 'li', @demoCheckBoxDoc.view()
            for cb in @demoCheckBoxes then m 'li', cb.view()

            m 'li', @demoButtonDoc.view()
            for btn in @demoButtons then m 'li', btn.view()

            m 'li', @demoBtnGroupDoc.view()
            for g in @demoBtnGroups
                m 'li', g.view()

            m 'li', @demoDatePickerDoc.view()
                for d in @demoDatePickers then m 'li', d.view()

            m 'li', @demoDateRangeDoc.view()
                for d in @demoDateRanges then m 'li', d.view()

            m 'li', @demoSwitchDoc.view()
            m 'li', @demoSwitch.view()

            m 'li', @demoDropDownDoc.view()
            for d in @demoDropDowns then m 'li', d.view()

            m 'li', @demoModalDoc.view()
            m 'li', @demoModalOpenBtn1.view(), @demoModal1.view()
            m 'li', @demoModalOpenBtn2.view(), @demoModal2.view()

            m 'li', @demoTextInputDoc.view()
            for t in @demoTextInputs
                m 'li', t.view()

            m 'li', @demoTagInputDoc.view()
            m 'li', @demoTagInput.view()


            m 'li', @demoTextAreaDoc.view()
            m 'li', @demoTextArea.view()
            m 'li', @demoTextArea2.view()


            m 'li', @demoTableViewDoc.view()
            for t in @demoTables then m 'li', t.view()

            m 'li', @demoCollaspeDoc.view()
            for c in @demoCollaspes
                m 'li', c.view()

            m 'li', @demoNotifyDoc.view()
            m 'li', @demoNotify1.view(), @demoNotify2.view()
            m 'li'
            ,   {className: 'NotifyBtnGroup'}
            ,   @demoNotifyOpenBtn1.view()
            ,   @demoNotifyOpenBtn1D.view()
            ,   @demoNotifyOpenBtn1D2.view()
            ,   @demoNotifyOpenBtn2.view()


            m 'li', @demoSpinnerDoc.view()
            m 'li',
                u.spinner '#2F88FF'
                u.spinner '#2F88FF', '5em'
                u.spinner '#2F88FF', '2em', '0.3s'

        m '.Misc',
            m 'span', 'Winter\'s ui collection'
            m 'a', href: 'https://github.com/winterland1989/mui', 'view code on github'
            m 'a', href: 'https://github.com/winterland1989/mui/blob/gh-pages/demo/index.coffee', 'this page\'s source'

    ]

s.tag s.merge [
    Button.mss
    ButtonThemed.mss
    ButtonDashed.mss
    ButtonWire.mss
    GroupButton.mss
    DatePicker.mss
    DateRange.mss
    Switch.mss
    CheckBox.mss
    DropDown.mss
    List.mss
    Modal.mss
    TextInput.mss
    TagInput.mss
    TextArea.mss
    Collaspe.mss
    Notify.mss
    Table.mss

    Modal:
        Button:
            display: 'inline-block'
            width: '200px'

    body:
        fontSize: '14px'
        fontFamily: 'Helvetica, Tahoma, Arial, "PingFang SC", "Hiragino Sans GB", "Heiti SC", "Microsoft YaHei", "WenQuanYi Micro Hei"'
        fontWeight: '400'

    Demo:
        listStyle: 'none'
        li:
            margin: '14px'

    Button_ButtonThemed:
        display: 'inline-block'
        marginRight: '4px'
        svg:
            width: '16px'
            margin: '-4px 2px 0 2px'
            verticalAlign: 'middle'
            fill: 'currentColor'


    NotifyBtnGroup:
        Button:
            width: '200px'

    Collaspe:
        width: '480px'
        textarea:
            resize: 'none'
            width: '100%'
            minHeight: '200px'
            border: 'none'
    Misc:
        position: 'fixed'
        top: 0
        right: 0
        padding: '14px'

        span_a:
            display: 'block'
            margin: '14px'


]


m.mount document.body, new Demo()
