m = require 'mithril'
s = require 'mss-js'
u = require './utils'
{ INPUT_WIDTH_MAP, BUTTON_WIDTH_MAP, BUTTON_HEIGHT_MAP, FONTSIZE_MAP } = require './CONSTANT'

class TextInput
    constructor: ({
        @value = ''             # String
    ,   @disabled = false       # Boolean (default = false)
    ,   @error = false          # Boolean (default = false)
    ,   @password = false       # Boolean (default = false)
    ,   @placeholder = ''       # String
    ,   @prefix = ''            # String
    ,   @suffix = ''            # String
    ,   @unit = ''              # String
    ,   @size = 'M'             # size: 'XS' | 'S' | 'M' | 'L' | 'XL'         (default = 'M')
    ,   @width = INPUT_WIDTH_MAP[@size] # '100%', '240px' ... (default = INPUT_WIDTH_MAP[@size])
    ,   @onPaste = u.noOp       # (value :: String, e :: DOMEvent) -> a
                                # triggered on Paste
    ,   @onChange = u.noOp      # (value :: String, e :: DOMEvent) -> a
                                # triggered on Blur or user stroke Enter
    ,   @onKeyup  = u.noOp      # (value :: String, e :: DOMEvent) -> a
                                # triggered when user stroke non-Enters
    ,   @onEnter  = u.noOp      # (value :: String, e :: DOMEvent) -> a
                                # triggered when user stroke Enter
    ,   @onClick = u.noOp       # (e :: DOMEvent) -> a
                                # triggered when user click the input


    }) ->

    onChangeInternal: (e) =>
        c = e.target.value
        @value = c
        @onChange c, e

    onPasteInternal: (e) =>
        console.log e
        c = (event.clipboardData || window.clipboardData).getData('text')
        @value = c
        @onPaste c, e

    onKeyupInternal: (e) =>
        c = e.target.value
        @value = c
        if (e.keyCode == 13 or e.key == "Enter")
            @onEnter c, e
        else @onKeyup c, e

    view: -> [
        m 'table.TextInput',
            className: if @error then 'Error' else ''
            style:
                width: @width
                height: BUTTON_HEIGHT_MAP[@size]
                lineHeight: BUTTON_HEIGHT_MAP[@size]
                fontSize: FONTSIZE_MAP[@size]
        ,
            m 'tr',
                if @prefix
                    m 'span.Prefix', @prefix
                m 'input.Input',
                    type: if @password then 'password' else ''
                    style:
                        height: BUTTON_HEIGHT_MAP[@size]
                        lineHeight: BUTTON_HEIGHT_MAP[@size]
                        fontSize: FONTSIZE_MAP[@size]
                    disabled: @disabled
                    onchange: @onChangeInternal
                    onkeyup: @onKeyupInternal
                    value: @value
                    placeholder: @placeholder
                    onclick: @onClick
                    onpaste: @onPasteInternal
                if @suffix
                    m 'span.Suffix', @suffix

                m 'span.Unit', @unit
    ]

TextInput.mss =
    TextInput:
        borderCollapse: 'separate'
        borderSpacing: 0
        borderRadius: '4px'
        border: '1px solid #DADFE3'
        position: 'relative'
        Unit:
            position: 'absolute'
            top: 0
            left: '100%'
            marginLeft: '16px'
        Prefix_Suffix:
            display: 'table-cell'
            background: '#F8F9FA'
            verticalAlign: 'middle'
            padding: '0 8px'
        Prefix:
            borderRight: '1px solid #DADFE3'
            borderRadius: '4px 0 0 4px'
        Suffix:
            borderLeft: '1px solid #DADFE3'
            borderRadius: '0 4px 4px 0'
        Input:
            width: '100%'
            verticalAlign: 'middle'
            margin: 0
            display: 'table-cell'
            color: '#333'
            outline: 0
            border: 'none'
            borderRadius: '4px'
            padding: '0 8px'
            verticalAlign: 'middle'
            $disabled:
                background: '#FCFCFC'
                cursor: 'not-allowed'
                color: '#D6D6D6'
    '.TextInput:hover':
        borderColor: '#2F88FF'
    '.TextInput.Error':
        borderColor: '#F45858'
        Prefix:
            borderColor: '#F45858'
        Suffix:
            borderColor: '#F45858'
    '.TextInput:focus-within':
        borderColor: '#2F88FF'
        boxShadow: '0 0 0 2px #2F88FF26'
        Prefix:
            borderColor: '#2F88FF'
        Suffix:
            borderColor: '#2F88FF'


module.exports = TextInput
