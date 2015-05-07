var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(["react", "reactRouter", "components/auth/index"], function(React, Router, auth) {
  var Link, Route, requireAuth;
  Route = Router.Route;
  Link = Router.Link;
  return requireAuth = (function(_this) {
    return function(Component) {
      var Authenticated;
      return Authenticated = (function(_super) {
        __extends(Authenticated, _super);

        function Authenticated() {
          return Authenticated.__super__.constructor.apply(this, arguments);
        }

        Authenticated.prototype.statics = {
          willTransitionTo: function(transition) {
            console.debug("auth.loggedIn()", auth.loggedIn());
            if (!auth.loggedIn()) {
              return transition.redirect('/login', {}, {
                'nextPath': transition.path
              });
            }
          }
        };

        Authenticated.prototype.propTypes = {
          user: React.PropTypes.instanceOf(User).isRequired
        };

        Authenticated.prototype.render = function() {
          return React.createElement(Component, React.__spread({}, this.props));
        };

        return Authenticated;

      })(React.Component);
    };
  })(this);
});
