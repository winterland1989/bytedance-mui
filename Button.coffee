m = require 'mithril'
s = require 'mss-js'
u = require './utils'
{ BUTTON_WIDTH_MAP, BUTTON_HEIGHT_MAP, FONTSIZE_MAP } = require './CONSTANT'

module.exports = class Button
    constructor: ({
        @label                      # String | mithril view | [mithril views]
    ,   @disabled = false           # Boolean (default = false)
    ,   @onClick = u.noOp           # (data :: String, e :: DOMEvent) -> a (default = ->)
    ,   @data = ''                  # String (default = '')
    ,   @size = 'M'                 # size: 'XS' | 'S' | 'M' | 'L' | 'XL'         (default = 'M')
    ,   @width ='FIXED'             # width: 'FIXED' | 'PADDING' | '100%', '123px'...       (default = '100px')
    }) ->

    onClickInternal: (e) =>
        unless @disabled
            data = u.getCurrentTargetData(e, 'data')
            @onClick(data, e)

    view: ->
        self = @
        m "button.Button"
            ,
                style:
                    padding: if @width == 'PADDING' then '0 16px' else 0
                    width:
                        if @width == 'PADDING' then 'auto'
                        else if @width == 'FIXED' then BUTTON_WIDTH_MAP[@size]
                        else @width
                    height: BUTTON_HEIGHT_MAP[@size]
                    lineHeight: BUTTON_HEIGHT_MAP[@size]
                    fontSize: FONTSIZE_MAP[@size]
                onclick: @onClickInternal
                'data-data': @data
                disabled: @disabled
            , @label

Button.mss =
    Button:
        position: 'relative'
        borderRadius: '4px'
        border: '1px solid #DADFE3'
        userSelect: 'none'
        textAlign: 'center'
        color: '#333'
        background: '#F8F9FA'
        cursor: 'pointer'
        $hover_$focus:
            borderColor: '#2F88FF'
            color: '#2F88FF'
        $disabled:
            borderColor: '#EDF1F5'
            background: '#FCFCFC'
            cursor: 'not-allowed'
            color: '#D6D6D6'
        $focus:
            outline: 'none'
            background: '#F0F9FF'
        $active:
            borderColor: '#1C68D9'
            color: '#1C68D9'
