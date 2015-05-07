define(["underscore", "react", "reactRouter", "components/auth/index"], function(_, React, Router, auth) {
  var Link, Route, requireAuth;
  Route = Router.Route;
  Link = Router.Link;
  return requireAuth = (function(_this) {
    return function(Component) {
      var Authenticated;
      Authenticated = _.extend(React.Component, {
        statics: {
          willTransitionTo: function(transition) {
            console.debug("auth.loggedIn()", auth.loggedIn());
            if (!auth.loggedIn()) {
              return transition.redirect('/login', {}, {
                'nextPath': transition.path
              });
            }
          }
        },
        render: function() {
          return React.createElement(Component, React.__spread({}, this.props));
        }
      });
      return Authenticated;
    };
  })(this);
});
