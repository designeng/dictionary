define(["react", "reactRouter", "components/ajax/ajaxRequest", "./userForm", "./step", "./inbox"], function(React, Router, AjaxRequest, UserForm, Step, Inbox) {
  var App, InitUserHandler, Link, Route, RouteHandler, StepHandler, routes;
  Route = Router.Route;
  RouteHandler = Router.RouteHandler;
  Link = Router.Link;
  StepHandler = React.createClass(Step);
  InitUserHandler = React.createClass({
    render: function() {
      var panelBodyClass, panelClass, panelHeadingClass, panelTitleClass;
      panelClass = "panel panel-default";
      panelBodyClass = "panel-body";
      panelTitleClass = "panel-title";
      panelHeadingClass = "panel-heading";
      return React.createElement("div", null);
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
  App = React.createClass({
    contextTypes: {
      router: React.PropTypes.func
    },
    componentDidMount: function() {
      return this.getState();
    },
    getState: function() {
      var stateServicePath;
      stateServicePath = "../api/web/v1/states";
      return new AjaxRequest(stateServicePath, null, "GET", "application/json").always(this.onGetState);
    },
    onGetState: function(result) {
      console.debug("STATE:::", result);
      if (result.state === "INIT_USER_STATE") {
        return this.context.router.transitionTo('user');
      } else if (result.state === "QUESTIONS_STATE") {
        return this.context.router.transitionTo('questions');
      }
    },
    render: function() {
      return React.createElement("div", null);
    }
  });
  routes = React.createElement(Route, {
    "path": "/",
    "handler": App
  }, React.createElement(Route, {
    "name": "user",
    "path": "user",
    "handler": InitUserHandler
  }), React.createElement(Route, {
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
