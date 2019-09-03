m = require 'mithril'
s = require 'mss-js'
u = require './utils'
{COLLASPE_ARROW} = require './CONSTANT'


class Collaspe
    constructor: ({
        @titleArray = []           # [String] | [mithril view]
                                   # [Boolean], same length as @widgetArray, composed with false (collasped) and true (expanded)
    ,   @widgetArray = []          # [String] | [mithril view]
    ,   @stateArray = (false for _ in @widgetArray)
    ,   @autoCollaspe = true       # Boolean (default = true)
        @iconType = 'RIGHT'        # 'RIGHT' | 'LEFT' | 'NONE'
    ,   @borderType = 'ALL'        # 'ALL' | 'HORIZONTAL' | 'NONE' (default = 'ALL')
    ,   @onExpand   = u.noOp       # (index :: Int, e :: DOMEvent) -> a
    ,   @onCollaspe = u.noOp       # (index :: Int, e :: DOMEvent) -> a
    }) ->

    onCollapseInternal: (e) =>
        i = parseInt (u.getCurrentTargetData e, 'index')
        if @autoCollaspe
            for s, j in @stateArray
                if s
                    if i != j
                        @onCollaspe j, e
                        @stateArray[j] = false

        if @stateArray[i] == false
            @stateArray[i] = true
            @onExpand i, e
        else
            @stateArray[i] = false
            @onCollaspe i, e

    view: ->
        self = @
        m '.Collaspe',
            style:
                borderWidth:
                    if @borderType == 'NONE' then '0'
                    else if @borderType == 'ALL' then '1px 1px 0 1px'
                    else '1px 0 0 0'
                borderRadius:
                    if @borderType == 'ALL' then '4px'
                    else 0

            for title, i in @titleArray
                expanded = @stateArray[i]
                m '.CollaspeGroup',
                    key: i
                    className: if expanded then 'Expanded' else ''
                ,
                    m '.CollaspeTitle',
                        'data-index': i
                        onclick: @onCollapseInternal
                    ,
                        m 'span.Icon',
                            className: [@iconType, if expanded then 'Expanded' else ''].join ' '
                        , m.trust COLLASPE_ARROW
                        m 'span.Title', title

                    m '.CollaspeBody',
                        style:
                            borderWidth:
                                if @borderType == 'NONE' then '0'
                                else if @borderType == 'ALL' and expanded then '1px 0 1px 0'
                                else '0 0 1px 0'
                        className: if expanded then 'Expanded' else ''
                    ,
                        if expanded then @widgetArray[i]

Collaspe.mss =
    Collaspe:
        boxSizing: 'border-box'
        borderStyle: 'solid'
        borderColor: '#DADFE3'
        overflow: 'hidden'
        CollaspeTitle:
            color: '#333'
            lineHeight: '32px'
            height: '32px'
            $hover:
                cursor: 'pointer'
            Title:
                verticalAlign: 'middle'
                marginLeft: '16px'
            Icon:
                margin: '11px 10px'
            svg:
                fill: '#666'
                width: '16px'
                verticalAlign: 'middle'
                transform: 'rotateZ(180deg)'
                transition: 'all 0.3s'

            LEFT:
                marginRight: '-10px'
                float: 'left'
                svg: transform: 'rotateZ(-90deg)'
            RIGHT:
                float: 'right'

            '.LEFT.Expanded':
                svg: transform: 'rotateZ(0)'
            '.RIGHT.Expanded':
                svg: transform: 'rotateZ(0)'

        CollaspeBody:
            borderStyle: 'solid'
            borderColor: '#DADFE3'

        '.CollaspeBody.Expanded':
            padding: '16px 32px'




module.exports = Collaspe
