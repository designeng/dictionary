define(["react", "reactRouter", "./userForm", "./step", "./inbox"], function(React, Router, UserForm, Step, Inbox) {
  var App, Link, Route, RouteHandler, StepHandler, routes;
  Route = Router.Route;
  RouteHandler = Router.RouteHandler;
  Link = Router.Link;
  StepHandler = React.createClass(Step);
  App = React.createClass({
    componentDidMount: function() {
      console.debug(".....");
      return $("#userForm").show();
    },
    render: function() {
      return React.createElement("div", null, React.createElement("h1", null, "Dictionary Test"), React.createElement(UserForm, {
        "endpoint": "../api/web/v1/sessions",
        "onsuccess": "questions"
      }), React.createElement(RouteHandler, null));
    }
  });
  routes = React.createElement(Route, {
    "path": "/",
    "handler": App
  }, React.createElement(Route, {
    "name": "questions",
    "path": "questions",
    "handler": StepHandler
  }), React.createElement(Route, {
    "name": "result",
    "path": "questions/result"
  }));
  return Router.run(routes, function(Handler) {
    return React.render(React.createElement(Handler, null), document.getElementById("application"));
  });
});
