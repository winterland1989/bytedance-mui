m = require 'mithril'
s = require 'mss-js'
u = require './utils'
TextInput = require './TextInput'
Button = require './Button'

{ CROSS } = require './CONSTANT'

class TagInput
    constructor: ({
          @tagList = []         # List of String
        , placeholder = ''      # String, placeholder of tag input
        , @separators = ' ,，'     # String, list of separators which will separate tags onkeyup
        , @onAdd = u.noOp       # (String) -> a, triggered on tag adding
        , @onDel = u.noOp       # (Int) -> a, triggered on tag deleting
        , @maxTagNum = Number.MAX_SAFE_INTEGER  # Int, limit the max tag user can input
    }) ->
        @tagInput = new TextInput
            content: ''
            placeholder: placeholder
            onEnter: @addTag
            onKeyup: @onKeyup

    onKeyup: (c) =>
        if @separators.indexOf(c) != -1
            @tagInput.content = @tagInput.content.substring(0, @tagInput.content.length-1)
            @addTag()
    addTag: =>
        tag = @tagInput.content
        if (@tagList.indexOf(tag) == -1) and (tag != '') and (@tagList.length < @maxTagNum)
            @tagList.push tag
            @onAdd(tag)
            @tagInput.content = ''

    delTag: (e) =>
        tag = u.getTargetData(e, 'tag')
        i = @tagList.indexOf(tag)
        if i != -1
            @tagList.splice(i, 1)
            @onDel(i)

    view: ->
        m '.TagInput',
            for tag in @tagList
                m '.TagItem',
                    m 'span', tag
                    m '.DelBtn',
                        'data-tag': tag
                        onclick: @delTag
                    , '✕'

            if @tagList.length < @maxTagNum
                m '.TagInputGroup',
                    @tagInput.view()
                    m '.AddBtn', onclick: @addTag, m.trust CROSS

TagInput.mss = s.merge [
    TextInput.mss

    TagInput:
        TagItem:
            display: 'inline-block'
            border: '1px solid ' + {}.border
            color: {}.text
            padding: '4px 12px'
            margin: '0 4px 4px 0'
            verticalAlign: 'middle'

            DelBtn:
                display: 'inline-block'
                marginLeft: '12px'
                color: {}.main
                cursor: 'pointer'
                $hover:
                    color: {}.warn

        TagInputGroup:
            position: 'relative'
            display: 'inline-block'
            verticalAlign: 'middle'
            margin: '0 4px 4px 0'
            width: '100px'
            TextInput:
                width: '100%'

        AddBtn:
            position: 'absolute'
            right: '0.2em'
            top: '0.165em'
            cursor: 'pointer'
            svg:
                fill: {}.main
                width: '1.6em'
                height: '1.6em'


]


module.exports = TagInput

