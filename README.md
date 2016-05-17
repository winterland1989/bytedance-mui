mui
===

A very simple ui library collection.

For demo and document, please check this little [demo page](http://winterland1989.github.io/mui/).

If you find bugs or get confused, fill a issue please.

usage
-----

+ use `npm` install `mui-js`, `mithril-js`, `mmsvg` and `mss-js` to your project.

+ use `webpack` as build tool.

Example usage:

```coffeescript
m = require 'mithril'
s = require 'mss-js'
Modal = require 'mui/Modal'

class Demo
    constructor: ->
        @modalElem = new Modal
            widget: view: ->
                m 'h', 'hello wolrd'


    view: -> [
        m 'button', {onclick: @modalElem.show}, 'show me'
        @modalElem.view()
    ]


s.tag Modal.mss

m.mount main, new Demo()
```

index
-----

+ AutoHide, add *hide on blur* to a widget (click anywhere outside will hide the widget).

+ Button, button with attachable data, prefix/suffix icon.

+ Collaspe, aka. accordion widget.

+ DatePicker, a simple date picker w/wo time select.

+ DropDown, a drop down selector.

+ Modal, add modal to a widget with auto centering.

+ Switch, a simple toggle button.

+ TextInput, a text input with validation.

+ i18n/style, feel free to modify.  utils, a helpers collection supporting this little library down to IE9.

customization
-------------

This library is intended to use with customization if needed, just run `npm run dev` under mui folder and change anything you want.


license
-------

Please do whatever you want to with this library : )
