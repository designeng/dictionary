define(["react", "reactRouter", "./step", "./inbox"], function(React, Router, Step, Inbox) {
  var App, AsyncElement, Link, PreQuestions, PreResult, Route, RouteHandler, routes;
  Route = Router.Route;
  RouteHandler = Router.RouteHandler;
  Link = Router.Link;
  AsyncElement = {
    loadedComponent: null,
    load: function() {
      if (this.constructor.loadedComponent) {
        return;
      }
      return this.bundle((function(_this) {
        return function(component) {
          _this.constructor.loadedComponent = component;
          return _this.forceUpdate();
        };
      })(this));
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
  PreQuestions = React.createClass({
    mixins: [AsyncElement],
    bundle: Step,
    preRender: function() {
      return React.createElement("div", null, "Loading questions...");
    }
  });
  PreResult = React.createClass({
    mixins: [AsyncElement],
    bundle: Inbox,
    preRender: function() {
      return React.createElement("div", null, "PreResult here");
    }
  });
  App = React.createClass({
    render: function() {
      var source;
      source = "js/service/word.json";
      return React.createElement("div", null, React.createElement("h1", null, "Dictionary Test"), React.createElement("ul", null, React.createElement("li", null, React.createElement(Link, {
        "to": "questions"
      }, "start questions")), React.createElement("li", null, React.createElement(Step, {
        "source": source
      }, "....."))), React.createElement(RouteHandler, null));
    }
  });
  routes = React.createElement(Route, {
    "handler": App
  }, React.createElement(Route, {
    "name": "questions",
    "path": "questions",
    "handler": PreQuestions
  }, React.createElement(Route, {
    "name": "result",
    "path": "questions/result",
    "handler": PreResult
  })));
  return Router.run(routes, function(Handler) {
    return React.render(React.createElement(Handler, null), document.getElementById("application"));
  });
});
