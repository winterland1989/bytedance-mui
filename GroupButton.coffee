m = require 'mithril'
s = require 'mss-js'
u = require './utils'
{ BUTTON_WIDTH_MAP, BUTTON_HEIGHT_MAP, FONTSIZE_MAP } = require './CONSTANT'

class GroupButton
    constructor: ({
        @textArray                # [String | mithril view]
    ,   @stateArray = (false for i in @textArray)       # [Boolean]
    ,   @disabledArray = (false for i in @textArray)    # [Boolean]
    ,   @multi = true             # Boolean
    ,   @size = 'M'                 # size: 'XS' | 'S' | 'M' | 'L' | 'XL'         (default = 'M')
    ,   @onSelect = u.noOp        # (Int) -> a
    ,   @onUnselect = u.noOp        # (Int) -> a
    }) ->

    onClickInternal: (e) =>
        i = parseInt (u.getCurrentTargetData e, 'index')
        if @disabledArray[i] then return
        unless @multi
            for s, j in @stateArray
                if s
                    if i != j
                        @onUnselect j
                        @stateArray[j] = false

        if @stateArray[i] == false
            @stateArray[i] = true
            @onSelect i
        else
            @stateArray[i] = false
            @onUnselect i

    view: ->
        m 'ul.GroupButton',
            style:
                height: BUTTON_HEIGHT_MAP[@size]
                lineHeight: BUTTON_HEIGHT_MAP[@size]
                fontSize: FONTSIZE_MAP[@size]
        ,
            for t, i in @textArray
                state = @stateArray[i]
                disabled = @disabledArray[i]

                m 'li.ButtonItem',
                    'data-index': i
                    className: [(if @multi then 'Multi' else ''),
                                    (if state then 'Selected' else ''),
                                        (if disabled then 'Disabled' else '')].join ' '
                    onclick: @onClickInternal
                , t

GroupButton.mss =
    GroupButton:
        margin: 0
        padding: 0
        listStyle: 'none'
        ButtonItem:
            userSelect: 'none'
            position: 'relative'
            display: 'inline-block'
            boxSizing: 'border-box'
            minWidth: '100px'
            verticalAlign: 'middle'
            padding: '0 16px'
            margin: '0 -1px 0 0'
            border: '1px solid #DADFE3'
            textAlign: 'center'
            color: '#333'
            background: '#FFF'
            cursor: 'pointer'
            zIndex: 1
            $hover_$pressed:
                borderColor: '#2F88FF'
                color: '#2F88FF'
            $pressed:
                outline: 'none'
                background: '#F0F9FF'
            $after:
                position: 'absolute'
                top: '2px'
                right: '2px'
                width: 0
                height: 0
                borderTop: '3.5px solid #DADFE3'
                borderRight: '3.5px solid #DADFE3'
                borderBottom: '3.5px solid #00000000'
                borderLeft: '3.5px solid #00000000'
        '.ButtonItem:first-child':
            borderRadius: '4px 0 0 4px'
        '.ButtonItem:last-child':
            borderRadius: '0 4px 4px 0'

        Multi: $after: content: '""'

        Selected:
            borderColor: '#1C68D9'
            color: '#1C68D9'
            zIndex: 3
            background: '#F0F9FF'
            $after:
                borderTop: '3.5px solid #2F88FF'
                borderRight: '3.5px solid #2F88FF'
                borderBottom: '3.5px solid #F0F9FF'
                borderLeft: '3.5px solid #F0F9FF'

        Disabled:
            borderColor: '#EDF1F5'
            background: '#FCFCFC'
            cursor: 'not-allowed'
            color: '#D6D6D6'
            zIndex: 0

        'Selected.Disabled':
            borderColor: '#A8D7FF'
            background: '#F0F9FF'
            cursor: 'not-allowed'
            color: '#A8D7FF'
            zIndex: 2
            $after:
                borderTop: '3.5px solid #A8D7FF'
                borderRight: '3.5px solid #A8D7FF'
                borderBottom: '3.5px solid #F0F9FF'
                borderLeft: '3.5px solid #F0F9FF'




module.exports = GroupButton


