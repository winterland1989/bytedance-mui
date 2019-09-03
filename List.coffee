m = require 'mithril'
s = require 'mss-js'
u = require './utils'
TextInput = require './TextInput'
{ BUTTON_WIDTH_MAP, BUTTON_HEIGHT_MAP, FONTSIZE_MAP, LIST_MAX_HEIGHT_MAP, SEARCH_LIST_MAX_HEIGHT_MAP} = require './CONSTANT'

class List
    constructor: ({
        @itemArray = []         # [String | mithril view]
    ,   @disabledArray = (false for i in @itemArray)     # [Boolean]
    ,   @searchPlaceHolder = ''  # String, (default = empty, disable searching)
                                 # filter function used when search item (default = (item, search) -> item.indexOf(search) != -1)
    ,   @filter = ((item, search) -> item.indexOf(search) != -1)
    ,   @currentIndex = -1  # Int
    ,   @onSelect = u.noOp  # (index :: Int, e :: DOMEvent) -> a (default = ->)
    ,   @size = 'M'         # size: 'XS' | 'S' | 'M' | 'L' | 'XL'         (default = 'M')
    ,   @width = '400px'    # '400px', '100%' ... (default = '400px')
    }) ->
        @initSearchInput()

    initSearchInput: =>
        if @searchPlaceHolder
            @searchInput = new TextInput
                size: @size
                width: 'calc(100% - 24px)'
                placeholder: @searchPlaceHolder

    onClickInternal: (e) =>
        i = parseInt(u.getCurrentTargetData e, 'index')
        @currentIndex = i
        @onSelect i, e

    view: ->
        m 'ul.List',
            style:
                width: @width
                maxHeight:
                    if @searchInput? then SEARCH_LIST_MAX_HEIGHT_MAP[@size]
                    else LIST_MAX_HEIGHT_MAP[@size]
            if @searchInput? then @searchInput.view()
            for item, i in @itemArray
                if !@searchInput? or @filter(item, @searchInput.value)
                    m 'li.ListItem',
                        className:
                            [ (if @disabledArray[i] then 'Disabled' else '')
                            , (if i == @currentIndex then 'Current' else '')
                            ].join ' '
                        style:
                            height: BUTTON_HEIGHT_MAP[@size]
                            lineHeight: BUTTON_HEIGHT_MAP[@size]
                            fontSize: FONTSIZE_MAP[@size]
                        onclick: @onClickInternal
                        'data-index': i
                    , item

List.mss =
    List:
        listStyle: 'none'
        padding: 0
        boxShadow: '0 2px 6px 0 #00000014'
        borderRadius: '4px'
        overflow: 'auto'
        color: '#333'
        userSelect: 'none'
        ListItem:
            padding: '0 12px'
            margin: 0
            cursor: 'pointer'
            $hover:
                background: '#EDF1F5'

        Disabled:
            cursor: 'disabled'
        Current:
            color: '#2F88FF'
        '.Disabled.Current':
            color: '#A8D7FF'

        $:
            TextInput.mss
        TextInput:
            margin: '12px 12px 6px'



module.exports = List
