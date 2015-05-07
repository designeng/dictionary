define(["react", "reactRouter", "./step", "./inbox"], function(React, Router, Step, Inbox) {
  var App, AsyncElement, Link, PreDashboard, PreInbox, Route, RouteHandler, routes;
  Route = Router.Route;
  RouteHandler = Router.RouteHandler;
  Link = Router.Link;
  AsyncElement = {
    loadedComponent: null,
    load: function() {
      if (this.constructor.loadedComponent) {
        return;
      }
      return this.bundle(function(component) {
        this.constructor.loadedComponent = component;
        return this.forceUpdate();
      }).bind(this);
    },
    componentDidMount: function() {
      return setTimeout(this.load, 1000);
    },
    render: function() {
      var Component;
      Component = this.constructor.loadedComponent;
      if (Component) {
        this.props.activeRoute = React.createElement(RouteHandler, null);
        return React.createElement(Component, React.__spread({}, this.props));
      }
      return this.preRender();
    }
  };
  PreDashboard = React.createClass({
    mixins: [AsyncElement],
    bundle: Step,
    preRender: function() {
      return React.createElement("div", null, "Loading dashboard...");
    }
  });
  PreInbox = React.createClass({
    mixins: [AsyncElement],
    bundle: Inbox,
    preRender: function() {
      return React.createElement("div", null, "Loading inbox...");
    }
  });
  App = React.createClass({
    render: function() {
      return React.createElement("div", null, React.createElement("h1", null, "Partial App"), React.createElement("ul", null, React.createElement("li", null, React.createElement(Link, {
        "to": "dashboard"
      }, "Dashboard"))), React.createElement(RouteHandler, null));
    }
  });
  routes = React.createElement(Route, {
    "handler": App
  }, React.createElement(Route, {
    "name": "dashboard",
    "path": "dashboard",
    "handler": PreDashboard
  }, React.createElement(Route, {
    "name": "inbox",
    "path": "dashboard/inbox",
    "handler": PreInbox
  })));
  return Router.run(routes, function(Handler) {
    return React.render(React.createElement(Handler, null), document.getElementById('example'));
  });
});
