m = require 'mithril'
s = require 'mss-js'
u = require './utils'
AutoHide = require './AutoHide'
DatePicker = require './DatePicker'
{ CALENDAR } = require './CONSTANT'

# sharing start date via .startDate
# sharing end date via .endDate
class DateRange
    constructor: ({
        startDate                     # Date
    ,   endDate                       # Date
    ,   @ifStartDateAvailable = (-> true)  # (Date) -> Boolean
    ,   @ifEndDateAvailable = (-> true)  # (Date) -> Boolean
    ,   @onSelect = u.noOp            # (startDate :: Date, endDate :: Date, e :: DOMEvent) -> a
    }) ->
        if startDate
            @startDate = u.clearDateHMS(new Date startDate)
        if endDate
            @endDate = u.clearDateHMS(new Date endDate)

        @startDatePicker = new DatePicker
            date: startDate
            ifDateAvailable: @ifStartDateAvailable
            onSelect: @onSelectInternal

        @endDatePicker = new DatePicker
            date: endDate
            ifDateAvailable: @ifEndDateAvailable
            onSelect: @onSelectInternal

        @datePickerWrapper = new AutoHide
            widget: view: =>
                m '.DateWrapper',
                    @startDatePicker.autoHideDatePicker.widget.view()
                    m '.DateEndWrapper',
                        @endDatePicker.autoHideDatePicker.widget.view()


        if @startDate? and @endDate?
            @startDatePicker.highlightStartDate = @endDatePicker.highlightStartDate = @startDate
            @startDatePicker.highlightEndDate = @endDatePicker.highlightEndDate = @endDate

    onSelectInternal: (d) =>
            if @startDate? and @endDate?
                @startDatePicker.highlightStartDate = @endDatePicker.highlightStartDate = null
                @startDatePicker.highlightEndDate = @endDatePicker.highlightEndDate = null
                @startDate = new Date d
                @endDate = null
            else if @startDate? and d.getTime() > @startDate.getTime()
                @endDate = new Date d
            else if @startDate? and d.getTime() < @startDate.getTime()
                @endDate = @startDate
                @startDate = new Date d
            else @startDate = new Date d

            if @startDate? and @endDate?
                @startDatePicker.highlightStartDate = @endDatePicker.highlightStartDate = @startDate
                @startDatePicker.highlightEndDate = @endDatePicker.highlightEndDate = @endDate
                @startDatePicker.date = null
                @endDatePicker.date = null
                @onSelect @startDate, @endDate

    view: ->
        m '.DatePicker.DateRange',
            m '.DateLabel',
                onclick: => @datePickerWrapper.show()
                className: unless @startDate? and @endDate? then 'Note' else ''
            ,
                if @startDate? and @endDate?
                    "#{u.formatDate(@startDate)} ~ #{u.formatDate(@endDate)}"
                else '请选择日期范围'
            m '.DateIcon', m.trust CALENDAR
            @datePickerWrapper.view()

DateRange.mss = s.merge [
    DatePicker.mss
    DateRange:
        DateWrapper:
            position: 'absolute'
            width: '576px'
            height: '280px'
            top: '38px'
            left: 0
            background: '#FFF'
            boxShadow: '0px 2px 6px 0px #00000014'
            borderRadius: '4px'
            zIndex: 1
            DatePickerWidget:
                top: 0
                boxShadow: 'none'
            DateEndWrapper:
                DatePickerWidget:
                    left: '288px'
]

module.exports = DateRange
