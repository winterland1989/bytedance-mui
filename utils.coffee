m = require 'mithril'

# get event's target
getTarget = (event) -> elem = event.target || event.srcElement

# get even's target's data-xxx
getTargetData = (event, dataStr) ->
    elem = event.target || event.srcElement
    if elem.dataset? then elem.dataset[dataStr]
    else elem.getAttribute('data-'+ dataStr)

# get even's current target's data-xxx
getCurrentTargetData = (event, dataStr) ->
    elem = event.currentTarget
    if elem.dataset? then elem.dataset[dataStr]
    else elem.getAttribute('data-'+ dataStr)

targetHasClass = (elem, str) ->
    (elem.className.indexOf str) != -1

# cancelBubble
cancelBubble = (e) ->
    # for IE
    if e.cancelBubble == false
        e.cancelBubble = true
    # others
    e.stopPropagation?()
    false


# clear Date's hour minute and second
clearDateHMS = (date) ->
    date.setHours 0
    date.setMinutes 0
    date.setSeconds 0
    date.setMilliseconds 0
    date

# format Date to yyyy-mm-dd
formatDate = (date) ->
    yyyy = date.getFullYear()
    mm = (date.getMonth() + 1)
    dd = date.getDate()

    yyyy + '-' + (formatXX mm) + '-' + (formatXX dd)

# format Date to yyyy-mm-dd
formatHMS = (date) ->
    hh = date.getHours()
    mm = date.getMinutes()
    ss = date.getSeconds()
    (formatXX hh) + ':' + (formatXX mm) + ':' + (formatXX ss)

# format Date to yyyy-mm-dd hh:mm:ss
formatDateWithHMS = (date) ->
    hh = date.getHours()
    mm = date.getMinutes()
    ss = date.getSeconds()

    (formatDate date) + ' ' + (formatHMS date)

# parse yyyy-mm-dd hh:mm:ss
# parse yyyy-mm-dd
parseDateWithHMS = (dateString) ->
    [dateStr, timeStr] = dateString.split ' '
    date = new Date dateStr
    if timeStr?
        [hh, mm, ss] = timeStr.split ':'
        date.setHours(parseInt hh)
        date.setMinutes(parseInt mm)
        date.setSeconds(parseInt ss)
    date

# helper to format number to 2 digit
formatXX = (x) -> if x < 10 then '0' + x.toString() else x.toString()

# find first Error in Array
firstErrorInArray = (arr) ->
    for x in arr
        if x instanceof Error then return x

# remove an element from array and return the origin index, return -1 if not in array
removeFromArray = (arr, x) ->
    i = arr.indexOf x
    if i != -1 then arr.splice i, 1
    i

svgCounter = 0
svg = (svg) ->
    m 'i', key: svgCounter++, svg

spinner = (color, size = '2em', interval = '1s') ->
    svg m.trust(
        """
        <svg version="1.1"
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            x="0px"
            y="0px"
            width="#{size}"
            viewBox="0 0 80 80"
            xml:space="preserve">
            <path
                fill="#{color}"
                d="M40,72C22.4,72,8,57.6,8,40C8,22.4,
                22.4,8,40,8c17.6,0,32,14.4,32,32c0,1.1-0.9,2-2,2
                s-2-0.9-2-2c0-15.4-12.6-28-28-28S12,24.6,12,40s12.6,
                28,28,28c1.1,0,2,0.9,2,2S41.1,72,40,72z"
                <!-- ANIMATION START -->
                <animateTransform
                    attributeType="xml"
                    attributeName="transform"
                    type="rotate"
                    from="0 40 40"
                    to="360 40 40"
                    dur="#{interval}"
                    repeatCount="indefinite"
                />
            </path>
        </svg>
        """
    )

debounce = (fn, delay, leading = false) ->
    pending = false

    if leading
        ->
            unless pending
                fn.apply this, arguments
                pending = true
                setTimeout (-> pending = false), delay

    else
        args = undefined
        ->
            args = arguments
            self = this
            unless pending
                pending = true
                setTimeout(
                    ->
                        pending = false
                        fn.apply self, args
                ,   delay
                )




module.exports = {
    getTarget
,   getTargetData
,   getCurrentTargetData
,   targetHasClass
,   cancelBubble
,   clearDateHMS
,   formatXX
,   formatDate
,   formatHMS
,   formatDateWithHMS
,   parseDateWithHMS
,   firstErrorInArray
,   removeFromArray
,   noOp: (->)

,   svg
,   spinner

,   debounce
}
