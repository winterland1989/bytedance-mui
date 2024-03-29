// Generated by CoffeeScript 1.12.7
(function() {
  var Switch, m, s, u,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  m = require('mithril');

  s = require('mss-js');

  u = require('./utils');

  Switch = (function() {
    function Switch(arg) {
      var ref, ref1;
      this.enable = (ref = arg.enable) != null ? ref : true, this.onToggle = (ref1 = arg.onToggle) != null ? ref1 : u.noOp;
      this.onToggleInternal = bind(this.onToggleInternal, this);
    }

    Switch.prototype.onToggleInternal = function(e) {
      this.enable = !this.enable;
      return this.onToggle(this.enable);
    };

    Switch.prototype.view = function() {
      return m('.Switch', {
        onclick: this.onToggleInternal,
        className: this.enable ? 'Enabled' : 'Disabled'
      }, m('.SwitchBtn'));
    };

    return Switch;

  })();

  Switch.mss = {
    '.Switch.Enabled': {
      width: '2em',
      height: '1em',
      borderRadius: '0.6em',
      padding: '0.15em',
      background: '#2F88FF',
      SwitchBtn: {
        left: '1em'
      }
    },
    '.Switch.Disabled': {
      width: '2em',
      height: '1em',
      borderRadius: '0.6em',
      padding: '0.15em',
      background: '#E4E9ED'
    },
    Switch: {
      display: 'inline-block',
      position: 'relative',
      boxSizing: 'content-box',
      SwitchBtn: {
        position: 'relative',
        width: '1em',
        height: '1em',
        borderRadius: '0.5em',
        background: '#fff',
        left: 0,
        transition: 'left 0.1s ease'
      }
    }
  };

  module.exports = Switch;

}).call(this);
