// Generated by CoffeeScript 1.10.0
(function() {
  var AutoHide, Dropdown, m, s, style, u,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  m = require('mithril');

  s = require('mss-js');

  style = require('./style');

  u = require('./utils');

  AutoHide = require('./AutoHide');

  Dropdown = (function() {
    function Dropdown(arg) {
      var ref, ref1;
      this.itemArray = arg.itemArray, this.currentIndex = arg.currentIndex, this.onSelect = (ref = arg.onSelect) != null ? ref : (function() {}), this.ifAvailable = (ref1 = arg.ifAvailable) != null ? ref1 : (function() {
        return true;
      });
      this.onSelectInternal = bind(this.onSelectInternal, this);
      this.autoComplete = bind(this.autoComplete, this);
      this.filter = '';
      this.autoHideDropDown = new AutoHide({
        onHide: (function(_this) {
          return function() {
            return _this.filter = '';
          };
        })(this),
        widget: {
          view: (function(_this) {
            return function() {
              var i, item;
              return m('ul.DropdownList', {
                onclick: _this.onSelectInternal
              }, (function() {
                var j, len, ref2, results;
                ref2 = this.itemArray;
                results = [];
                for (i = j = 0, len = ref2.length; j < len; i = ++j) {
                  item = ref2[i];
                  if ((item.indexOf(this.filter)) !== -1) {
                    results.push(m('li.DropdownItem', {
                      key: i,
                      className: (this.currentIndex === i ? 'Current ' : '') + (this.ifAvailable(item, i) ? 'Available' : ''),
                      'data-index': i,
                      'data-content': item
                    }, item));
                  }
                }
                return results;
              }).call(_this));
            };
          })(this)
        }
      });
    }

    Dropdown.prototype.autoComplete = function(e) {
      return this.filter = (u.getTarget(e)).value;
    };

    Dropdown.prototype.onSelectInternal = function(e) {
      var content, index;
      if (u.targetHasClass(u.getTarget(e), 'Available')) {
        index = parseInt(u.getTargetData(e, 'index'));
        content = u.getTargetData(e, 'content');
        if (!isNaN(index)) {
          this.currentIndex = index;
          this.filter = '';
          this.autoHideDropDown.hide();
          return this.onSelect(content, index);
        }
      }
    };

    Dropdown.prototype.view = function() {
      return m('.Dropdown', m('input.DropdownInput', {
        onchange: this.autoComplete,
        onclick: this.autoHideDropDown.show,
        value: this.filter ? this.filter : this.itemArray[this.currentIndex]
      }), this.autoHideDropDown.view());
    };

    return Dropdown;

  })();

  Dropdown.mss = {
    Dropdown: {
      position: 'relative',
      width: '200px',
      DropdownInput: {
        display: 'block',
        lineHeight: '2em',
        fontSize: '0.9em',
        width: '100%',
        textAlign: 'center',
        border: '1px solid ' + style.border[4]
      },
      DropdownList: {
        position: 'absolute',
        top: '2em',
        border: '1px solid #ccc',
        width: '198px',
        height: '200px',
        margin: 0,
        padding: 0,
        listStyle: 'none',
        background: '#fff',
        overflowY: 'auto',
        zIndex: 999,
        DropdownItem: s.LineSize('2em', '0.9em')({
          textAlign: 'center',
          overflowX: 'hidden',
          padding: '0 4px',
          margin: 0,
          color: style.text[5],
          $hover: {
            cursor: 'pointer',
            background: style.main[5],
            color: style.text[8]
          }
        }),
        Available: {
          color: style.text[0]
        }
      }
    }
  };

  module.exports = Dropdown;

}).call(this);
