m = require 'mithril'
s = require 'mss-js'
u = require './utils'

{ CHECK_SVG, HYPHEN_SVG } = require './CONSTANT'


class CheckBox
    constructor: ({
        @checked = true     # Boolean
    ,   @label = 'foo'       # String
    ,   @disabled = false    # Boolean
    ,   @partial = false     # Boolean
    ,   @onToggle = u.noOp   # (checked :: Boolean, e :: DOMEvent) -> a
    }) ->

    onToggleInternal: (e) =>
        @checked = not @checked
        @onToggle @selected, e

    view: ->
        m 'label.CheckBox'
        ,
            m 'input',
                onchange: @onToggleInternal
                type: 'checkbox'
                checked: @checked
                disabled: @disabled
            m '.CheckMark',
                if @checked then (if @partial then m.trust HYPHEN_SVG else m.trust CHECK_SVG)
            m '.CheckLabel', @label

CheckBox.mss =
    CheckBox:
        display: 'inline-block'
        verticalAlign: 'middle'
        cursor: 'pointer'
        input: display: 'none'
        verticalAlign: 'middle'
        userSelect: 'none'

        CheckMark:
            display: 'inline-block'
            height: '16px'
            width: '16px'
            boxSizing: 'border-box'
            borderRadius: '2px'
            verticalAlign: 'middle'
            border: '1px solid #2F88FF'
            background: 'none'
            svg:
                width: '10px'
                height: '10px'
                margin: '2px'
                fill: '#FFF'

        CheckLabel:
            display: 'inline-block'
            marginLeft: '8px'
            color: '#333'

        'input:disabled ~ .CheckLabel':
            color: '#D6D6D6'

        'input:disabled ~ .CheckMark':
            background: '#FCFCFC'
            border: '1px solid #EDF1F5'

        'input:checked ~ .CheckMark':
            background: '#2F88FF'
            svg:
                fill: '#fff'

        'input:disabled:checked ~ .CheckMark':
            background: '#A8D7FF'
            border: '1px solid #A8D7FF'
            svg:
                fill: '#fff'


module.exports = CheckBox

