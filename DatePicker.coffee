m = require 'mithril'
s = require 'mss-js'
u = require './utils'
AutoHide = require './AutoHide'

{ DAY_NAME, LEFT_DOUBLE_ARROW, LEFT_ARROW, RIGHT_DOUBLE_ARROW, RIGHT_ARROW, CALENDAR} = require './CONSTANT'

# sharing date via .date
class DatePicker
    constructor: ({
        date                         # Date
    ,   @ifDateAvailable = (-> true) # (Date) -> Boolean
    ,   @onSelect = u.noOp           # (date :: Date, e :: DOMEvent) -> a
    ,   highlightStartDate           # Date
    ,   highlightEndDate             # Date
    }) ->
        if date
            @date = u.clearDateHMS(new Date date)
            @internalDate = u.clearDateHMS(new Date date)
        else
            @date = null
            @internalDate = u.clearDateHMS(new Date)
        if highlightStartDate
            @highlightStartDate = u.clearDateHMS(new Date highlightStartDate)
        if highlightEndDate
            @highlightEndDate = u.clearDateHMS(new Date highlightEndDate)

        @calculateStartDate()
        @autoHideDatePicker = new AutoHide
            widget: view: =>
                m '.DatePickerWidget',
                    m '.NavBar',
                        m 'span.PreYear', onclick: @preYear, m.trust LEFT_DOUBLE_ARROW
                        m 'span.PreMonth', onclick: @preMonth,  m.trust LEFT_ARROW
                        m 'span.CurrentMonth',
                            @internalDate.getFullYear() + '年 ' + (@internalDate.getMonth() + 1) + '月'
                        m 'span.NextMonth', onclick: @nextMonth, m.trust RIGHT_ARROW
                        m 'span.NextYear', onclick: @nextYear, m.trust RIGHT_DOUBLE_ARROW

                    m '.DayBar',
                        for d in DAY_NAME
                            m 'span.Day', d

                    m '.DateList', onclick: @selectDate,
                        for d in [0..41]
                            dObj = new Date(@startDate.getTime() + d*24*3600*1000)
                            monthStart = (new Date(@internalDate))
                            monthStart.setDate(1)
                            monthEnd = (new Date(@internalDate))
                            monthEnd.setMonth(@internalDate.getMonth() + 1)
                            monthEnd.setDate(0)

                            m 'span.Date',
                                className:
                                    [
                                        if (dObj >= monthStart and dObj <= monthEnd) then 'InMonth'
                                    ,
                                        unless @ifDateAvailable(dObj) then 'Unavailable' else ''
                                    ,
                                        if (dObj.getTime() == @date?.getTime()) then 'Current' else ''
                                    ,
                                        if @highlightStartDate?.getTime() < dObj.getTime() < @highlightEndDate?.getTime()
                                            'Highlight'
                                        else ''
                                    ,
                                        if @highlightStartDate?.getTime() == dObj.getTime()
                                            'HighlightStart'
                                        else if @highlightEndDate?.getTime() == dObj.getTime()
                                            'HighlightEnd'
                                    ].join ' '
                                'data-year': dObj.getFullYear()
                                'data-month': dObj.getMonth()
                                'data-date': dObj.getDate()

                            , dObj.getDate()


    calculateStartDate: ->
        # from which day?
        monthStart = new Date @internalDate
        monthStart.setDate(1)
        d = monthStart.getTime()
        for i in [0..6]
            @startDate = (new Date(d - i * 24 * 3600 * 1000))
            if @startDate.getDay() == 0 then return

    preMonth: (e) =>
        @internalDate.setMonth(@internalDate.getMonth() - 1)
        @calculateStartDate()
        u.cancelBubble e

    nextMonth: (e) =>
        @internalDate.setMonth(@internalDate.getMonth() + 1)
        @calculateStartDate()
        u.cancelBubble e

    preYear: (e) =>
        @internalDate.setFullYear(@internalDate.getFullYear() - 1)
        @calculateStartDate()
        u.cancelBubble e

    nextYear: (e) =>
        @internalDate.setFullYear(@internalDate.getFullYear() + 1)
        @calculateStartDate()
        u.cancelBubble e

    selectDate: (e) =>
        unless u.targetHasClass (u.getTarget e), 'Unavailable'
            if u.getTargetData(e, 'year')
                @date ?= u.clearDateHMS(new Date)
                @date.setFullYear u.getTargetData(e, 'year')
                @date.setMonth u.getTargetData(e, 'month')
                @date.setDate u.getTargetData(e, 'date')
                @onSelect @date, e

    view: ->
        m '.DatePicker',
            className: if @autoHideDatePicker.showing then 'Expanded' else ''
        ,
            m '.DateLabel',
                onclick: @autoHideDatePicker.show
                className: unless @date then 'Note' else ''
            , if @date then u.formatDate @date else '请选择日期'
            m '.DateIcon', m.trust CALENDAR
            @autoHideDatePicker.view()

DatePicker.mss =
    DatePicker:
        position: 'relative'
        width: '240px'
        fontSize: '14px'
        color: '#333'
        DateLabel:
            boxSizing: 'border-box'
            height: '34px'
            lineHeight: '32px'
            paddingLeft: '12px'
            border: '1px solid #DADFE3'
            borderRadius: '4px'
            cursor: 'pointer'
            $hover:
                borderColor: '#2F88FF'
        Note: color: '#D6D6D6'
        DateIcon:
            position: 'absolute'
            top: '5px'
            right: '12px'
            svg:
                width: '14px'
                fill: '#999'

        DatePickerWidget:
            position: 'absolute'
            userSelect: 'none'
            width: '288px'
            height: '280px'
            top: '38px'
            left: 0
            background: '#FFF'
            boxShadow: '0px 2px 6px 0px #00000014'
            borderRadius: '4px'
            zIndex: 1
            NavBar:
                textAlign: 'center'
                lineHeight: '38px'
                height: '38px'
                background: '#F8F9FA'
                borderRadius: '3px 3px 0 0'
                position: 'relative'

                PreYear_PreMonth_NextMonth_NextYear:
                    position: 'absolute'
                    top: '6px'
                    width: '16px'
                    svg:
                        width: '16px'
                        stroke: '#999'
                    cursor: 'pointer'
                    $hover: svg: stroke: '#2F88FF'

                PreYear: left: '12px'
                PreMonth: left: '40px'
                NextYear: right: '12px'
                NextMonth: right: '40px'


                CurrentMonth:
                    display: 'inline-block'
                    fontWeight: '600'

            DayBar:
                padding: '16px 16px 0'
                Day:
                    display: 'inline-block'
                    width: '24px'
                    height: '24px'
                    lineHeight: '22px'
                    textAlign: 'center'
                    fontSize: '14px'
                    margin: '3px 6px'

            DateList:
                padding: '0px 16px 18px'
                Date:
                    boxSizing: 'border-box'
                    display: 'inline-block'
                    verticalAlign: 'middle'
                    width: '24px'
                    height: '24px'
                    lineHeight: '22px'
                    textAlign: 'center'
                    fontSize: '14px'
                    margin: '3px 6px'
                    borderRadius: '4px'
                    cursor: 'pointer'
                    color: '#D6D6D6'
                InMonth:
                    color: '#333'

                Current:
                    boxSizing: 'border-box'
                    color: '#2F88FF'
                    border: '1px solid #2F88FF'
                    position: 'relative'
                    zIndex: 1

                Unavailable:
                    color: '#D6D6D6'
                    cursor: 'not-allowed'
                Highlight:
                    width: '48px'
                    height: '22px'
                    margin: '4px -6px'
                    background: '#EDF1F5'
                    borderRadius: 0
                'Highlight.Current':
                    border: 'none'
                HighlightStart_HighlightEnd:
                    position: 'relative'
                    background: '#2F88FF'
                    color: '#FFF'
                HighlightStart:
                    $after:
                        content: '""'
                        position: 'absolute'
                        width: '12px'
                        height: '22px'
                        background: '#EDF1F5'
                        top: '0.5px'
                        right: '-12px'
                HighlightEnd:
                    $after:
                        content: '""'
                        position: 'absolute'
                        width: '12px'
                        height: '22px'
                        background: '#EDF1F5'
                        top: '0.5px'
                        left: '-12px'


    Expanded:
        DateLabel:
            borderColor: '#2F88FF'
            boxShadow: '0 0 0 2px #2F88FF26'


module.exports = DatePicker
