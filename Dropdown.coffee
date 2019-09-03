m = require 'mithril'
s = require 'mss-js'
u = require './utils'

AutoHide = require './AutoHide'
List = require './List'
{ COLLASPE_ARROW, BUTTON_HEIGHT_MAP, FONTSIZE_MAP } = require './CONSTANT'

class Dropdown
    constructor: ({
        @itemArray = []         # [String | mithril view]
    ,   @disabledArray = (false for i in @itemArray)     # [Boolean]
    ,   @searchPlaceHolder = ''  # String, (default = empty, disable searching)
                                 # filter function used when search item (default = (item, search) -> item.indexOf(search) != -1)
    ,   @filter = ((item, search) -> item.indexOf(search) != -1)
    ,   @currentIndex = -1  # Int
    ,   @onSelect = u.noOp  # (index :: Int, e :: DOMEvent) -> a (default = ->)
    ,   @placeholder = '请选择...'  # String
    ,   @disabled = false   # Boolean
    ,   @size = 'M'         # size: 'XS' | 'S' | 'M' | 'L' | 'XL'         (default = 'M')
    ,   @width = '400px'    # '400px', '100%' ... (default = '400px')
    }) ->
        @initList()

    initList: ->
        @autoHideList = new AutoHide
            onHide: => @filter = ''
            widget: new List
                itemArray: @itemArray
                disabledArray: @disabledArray
                searchPlaceHolder: @searchPlaceHolder
                filter: @filter
                currentIndex: @currentIndex
                onSelect: @onSelectInternal
                size: @size
                width: @width

    autoComplete: (e) =>
        @filter = (u.getTarget e).value
        if @filter == '' then @currentIndex = undefined


    onSelectInternal: (i, e) =>
        unless @disabled
            @currentIndex = i
            @autoHideList.hide()
            @onSelect(i, e)
            u.cancelBubble e

    onShowListIntertal: =>
        unless @disabled
            @autoHideList.show()

    view: ->
        m '.Dropdown',
            style: width: @width
            onclick: @onShowListIntertal
            className:
                [ (if @autoHideList.showing then 'Expanded' else '')
                  (if @disabled then 'Disabled' else '')
                ].join ' '
        ,
            m '.DropdownContent',
                style:
                    height: BUTTON_HEIGHT_MAP[@size]
                    lineHeight: BUTTON_HEIGHT_MAP[@size]
                    fontSize: FONTSIZE_MAP[@size]
                className:
                    [   (if @disabled then 'Disabled' else '')
                        (if @currentIndex < 0 then 'Note' else '')
                    ].join ' '
                if @currentIndex >= 0 then @itemArray[@currentIndex]
                else @placeholder
                m '.DownArrow', m.trust COLLASPE_ARROW
            @autoHideList.view()

Dropdown.mss =
    Dropdown:
        DropdownContent:
            position: 'relative'
            verticalAlign: 'middle'
            margin: 0
            color: '#333'
            outline: 0
            border: '1px solid #DADFE3'
            cursor: 'pointer'
            borderRadius: '4px'
            padding: '0 8px'
            verticalAlign: 'middle'
            $hover:
                borderColor: '#2F88FF'
                DownArrow: svg: fill: '#2F88FF'
        Note: color: '#C1C1C1'
        DownArrow:
            position: 'absolute'
            right: '12px'
            top: '50%'
            marginTop: '-4px'
            svg:
                fill: '#666'
    Expanded:
        DropdownContent:
            borderColor: '#2F88FF'
            boxShadow: '0 0 0 2px #2F88FF26'
        DownArrow:
            DownArrow: svg: fill: '#2F88FF'

    Disabled:
        DropdownContent:
            background: '#FCFCFC'
            cursor: 'not-allowed'
            color: '#D6D6D6'

module.exports = Dropdown
