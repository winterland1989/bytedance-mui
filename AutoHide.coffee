m = require 'mithril'
u = require './utils'

class AutoHide
    constructor: ({
        @widget             # mithril widget
    ,   @onHide = u.noOp    # () -> a
    }) ->
        @showing = false # Boolean

    onHideInternal: (elem) -> (e) =>
        unless elem.contains e.target
            @showing = false
        m.redraw()
        # don't cancel event bubbling
        @onHide()
        true

    show: => @showing = true
    hide: =>
        @showing = false
        @onHide()

    view: ->
        self = @
        m '.HideOnBlur'
        ,
            oncreate: (vnode) ->
                window.addEventListener 'click', self.onHideInternal(vnode.dom), true
            onremove: (vnode) ->
                window.removeEventListener 'click', self.onHideInternal(vnode.dom), true

        ,   if @showing then @widget.view()

module.exports = AutoHide
