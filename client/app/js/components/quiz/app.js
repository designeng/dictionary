define(["react", "reactRouter", "./userForm", "./step", "./inbox"], function(React, Router, UserForm, Step, Inbox) {
  var App, Link, Route, RouteHandler, StepHandler, routes;
  Route = Router.Route;
  RouteHandler = Router.RouteHandler;
  Link = Router.Link;
  StepHandler = React.createClass(Step);
  App = React.createClass({
    componentDidMount: function() {
      return $("#userForm").show();
    },
    render: function() {
      var panelBodyClass, panelClass, panelHeadingClass, panelTitleClass;
      panelClass = "panel panel-default";
      panelBodyClass = "panel-body";
      panelTitleClass = "panel-title";
      panelHeadingClass = "panel-heading";
      return React.createElement("div", {
        "className": panelClass
      }, React.createElement("div", {
        "className": panelHeadingClass
      }, React.createElement("h3", {
        "className": panelTitleClass
      }, "Dictionary Quiz")), React.createElement("div", {
        "className": panelBodyClass
      }, React.createElement(UserForm, {
        "endpoint": "../api/web/v1/sessions",
        "onsuccess": "questions"
      })), React.createElement(RouteHandler, null));
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
