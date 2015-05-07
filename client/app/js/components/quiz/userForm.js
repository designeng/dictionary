define(["underscore", "jquery", "react", "reactRouter", "components/ajax/ajaxRequest"], function(_, $, React, Router, AjaxRequest) {
  var Link, Route, UserForm;
  Route = Router.Route;
  Link = Router.Link;
  return UserForm = React.createClass({
    validateForm: function() {
      var userName;
      userName = $.trim($("#userName").val());
      if (!userName) {
        alert("Input userName!");
        return false;
      }
      return true;
    },
    userEndpointRequest: function() {
      if (this.validateForm()) {
        return new AjaxRequest(this.props.endpoint, null, "GET", "application/json").always(this.afterSendRequest);
      }
    },
    afterSendRequest: function(result) {
      console.debug("result", result);
      if (this.isMounted()) {
        return this.setState({
          id: result.id,
          word: result.word,
          choises: result.choises
        });
      }
    },
    render: function() {
      return React.createElement("form", null, React.createElement("input", {
        "type": "text",
        "id": "userName",
        "name": "userName",
        "placeholder": "User Name"
      }), React.createElement("input", {
        "type": "button",
        "value": "Start quiz",
        "onClick": this.userEndpointRequest
      }));
    }
  });
});
