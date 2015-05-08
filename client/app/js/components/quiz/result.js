define(["underscore", "jquery", "react", "reactRouter", "components/ajax/ajaxRequest"], function(_, $, React, Router, AjaxRequest) {
  var Link, Result, Route;
  Route = Router.Route;
  Link = Router.Link;
  return Result = React.createClass({
    componentDidMount: function() {},
    render: function() {
      var resultClass;
      resultClass = "result";
      return React.createElement("div", {
        "className": resultClass
      }, "RESULT");
    }
  });
});
