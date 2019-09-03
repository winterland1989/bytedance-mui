m = require 'mithril'
s = require 'mss-js'

u = require './utils'

###
columns :: [columnObject]

columnObject ::
    key: Int | String
    title :: String | mithril view
    textAlign: 'left' | 'center' | 'right' (default = 'left')
    emptyPlaceHolder: String, '-', ...     (default = '')
    minWidth:  'xxPx'                      (default = 'auto')
    width: 'xxPx'                          (default = 'auto')
    sort: (key, order :: 'ASC' | 'DESC') -> , works on data property   (default = null)
    sorting :: '' | 'ASC' | 'DESC' (default = '')
    fixed :: '' | 'LEFT' | 'RIGHT'

data :: [{key1 :: value1, key2 :: value2 ...}]

value :: String | mithril view

totalWidth :: String (default = '100%')
border :: 'HORIZONTAL' | 'ALL' (default = 'ALL')
striped :: Boolean (default = true)
###

class Table
    constructor: ({
        @columns
    ,   @data
    ,   @mainWidth = '100%'
    ,   @mainScrollWidth = '100%'
    ,   @innerShadow = 'NONE'
    ,   @borderType = 'ALL'
    ,   @striped = true}) ->

        @initColumns()

    initColumns: =>
        @leftColumns = []
        @mainColumns = []
        @rightColumns = []
        for c in @columns
            if c.fixed == 'LEFT' then @leftColumns.push c
            else if c.fixed == 'RIGHT' then @rightColumns.push c
            else @mainColumns.push c

    sort: =>

    view: ->
        m '.TableView',
            style: width: @totalWidth
        ,
            if @leftColumns.length
                m '.LeftTable',
                    m 'table.LeftTable', @tableBody @leftColumns

            m '.MainTable', {style: width: @mainScrollWidth },
                m 'table',  {style: width: @mainWidth }, @tableBody @mainColumns

            if @rightColumns.length
                m '.RightTable',
                    m 'table.RightTable', @tableBody @rightColumns

    tableBody: (columns) -> [
        m 'thead',
            m 'tr',
                for c in columns
                    m 'th',
                        style:
                            borderWidth: if @borderType == 'HORIZONTAL' then '1px 0' else '1px'
                            width: if c.width then c.width else 'auto'
                            minWidth: if c.minWidth then c.minWidth else 'auto'
                        m 'span', c.title
                        if c.sort
                            m '.Sorting'

        m 'tbody',
            for d, i in @data
                m 'tr',
                    key: i
                    style: background: if (i % 2 == 1) and @striped then '#F8F9FA' else '#FFF'
                ,
                    for c in columns
                        m 'td',
                            style:
                                borderWidth: if @borderType == 'HORIZONTAL' then '1px 0' else '1px'
                        , if d[c.key] then d[c.key] else c.emptyPlaceHolder
    ]

Table.mss =
    TableView:
        position: 'relative'
        LeftTable:
            position: 'relative'
            boxShadow: '6px 0 6px -6px #00000014'
            marginRight: '-1px'
            zIndex: 3
        RightTable:
            position: 'relative'
            boxShadow: '-6px 0 6px -6px #00000014'
            marginLeft: '-1px'
            zIndex: 3
        MainTable:
            position: 'relative'
            overflowX: 'auto'
        LeftTable_MainTable_RightTable:
            display: 'inline-block'
            table:
                overflow: 'auto'
                borderCollapse: 'collapse'
                th_td:
                    borderStyle: 'solid'
                    borderColor: '#DADFE3'
                    textAlign: 'center'
                    color: '#333'
                    lineHeight: '22px'
                th:
                    background: '#F8F9FA'
                    verticalAlign: 'middle'
                    fontWeight: '500'
                    height: '48px'
                td:
                    padding: '10px 16px'

module.exports = Table
