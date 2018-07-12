// Generated by CoffeeScript 1.12.7
(function() {
  var QuestionMark, helpIcon, m, s, style, u;

  m = require('mithril');

  s = require('mss-js');

  u = require('./utils');

  style = require('./style');

  helpIcon = require('mmsvg/google/msvg/action/help');

  QuestionMark = (function() {
    function QuestionMark(arg) {
      var ref, ref1;
      this.icon = (ref = arg.icon) != null ? ref : helpIcon, this.message = (ref1 = arg.message) != null ? ref1 : "hello world!";
    }

    QuestionMark.prototype.view = function() {
      return m('.QuestionMark', m('span', this.icon), m('.Message', m.trust(this.message)));
    };

    return QuestionMark;

  })();

  QuestionMark.mss = {
    QuestionMark: {
      position: 'relative',
      display: 'inline-block',
      width: '2em',
      height: '2em',
      svg: {
        fill: style.main[4]
      },
      Message: {
        display: 'none'
      },
      $hover: {
        Message: {
          color: '#fff',
          width: '200px',
          left: '2em',
          top: '-0.2em',
          position: 'absolute',
          display: 'block',
          background: style.main[4],
          padding: '0.5em',
          $before: {
            content: '""',
            position: 'absolute',
            top: 0,
            left: '-1.5em',
            width: 0,
            height: 0,
            border: '1em solid transparent',
            borderRight: '1em solid ' + style.main[4]
          }
        }
      }
    }
  };

  module.exports = QuestionMark;

}).call(this);
