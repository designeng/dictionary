define(["underscore", "jquery", "react", "components/ajax/ajaxRequest"], function(_, $, React, AjaxRequest) {
  var Result;
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
