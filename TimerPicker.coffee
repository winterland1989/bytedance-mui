
    setHMS: (e) =>
        hour = parseInt (u.getTargetData(e, 'hour'))
        unless isNaN hour then @date.setHours hour
        min = parseInt (u.getTargetData(e, 'min'))
        unless isNaN min then @date.setMinutes min
        second = parseInt (u.getTargetData(e, 'second'))
        unless isNaN second then @date.setSeconds second
        @onSelect @date

    scrollToView: (vnode) ->
        elem = vnode.dom
        if u.targetHasClass elem, 'Current'
            offsetTop = elem.offsetTop
            elem.parentNode.scrollTop = offsetTop



                    if @selectTime then [
                        m '.TimeBar',
                            m 'span.TimeLabel', i18n.hour
                            m 'span.TimeLabel', i18n.minute
                            m 'span.TimeLabel', i18n.second


                        m '.TimeList', onclick: @setHMS,
                            m 'ul.HourList',
                                for hour, i in hourArray then m 'li' ,
                                        oncreate: @scrollToView
                                        key: i
                                        className: if hour == u.formatXX @date.getHours() then 'Current' else ''
                                        'data-hour': hour
                                    , hour
                            m 'ul.MinuteList',
                                for min, i in minuteArray then m 'li' ,
                                        oncreate: @scrollToView
                                        key: i
                                        className: if min == u.formatXX @date.getMinutes() then 'Current' else ''
                                        'data-min': min
                                    ,   min
                            m 'ul.SecondList',
                                for second, i in secondArray then m 'li',
                                        oncreate: @scrollToView
                                        key: i
                                        className: if second == u.formatXX @date.getSeconds() then 'Current' else ''
                                        'data-second': second
                                    ,   second





            TimeBar:
                borderTop: '1px solid ' + {}.border
                TimeLabel:
                    padding: '8px 0'
                    fontSize: '0.9em'
                    display: 'inline-block'
                    width: '80px'
                    textAlign: 'center'

            TimeList:
                HourList_MinuteList_SecondList:
                    position: 'relative'
                    padding: 0
                    margin: 0
                    marginBottom: '8px'
                    display: 'inline-block'
                    height: '80px'
                    width: '80px'
                    overflow: 'auto'
                    listStyle: 'none'
                    li:
                        fontSize: '0.9em'
                        textAlign: 'center'
                        margin: '0.2em'
                        $hover:
                            color: {}.text
                            background: {}.main
                    Current:
                        color: {}.text
                        background: {}.main
