define(["underscore", "jquery", "react", "reactRouter", "components/ajax/ajaxRequest"], function(_, $, React, Router, AjaxRequest) {
  var Link, Route, UserForm;
  Route = Router.Route;
  Link = Router.Link;
  return UserForm = React.createClass({
    componentDidMount: function() {
      return $("#userForm").show();
    },
    onChange: function() {},
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
        this.setState({
          id: result.id,
          word: result.word,
          choises: result.choises
        });
      }
      if ((result != null) && !result.error) {
        window.location.hash = "questions";
        return $("#userForm").hide();
      }
    },
    render: function() {
      return React.createElement("form", {
        "id": "userForm"
      }, React.createElement("input", {
        "type": "text",
        "value": "azxcv",
        "id": "userName",
        "name": "userName",
        "placeholder": "User Name",
        "onChange": this.onChange
      }), React.createElement("input", {
        "type": "button",
        "value": "Start quiz",
        "onClick": this.userEndpointRequest
      }));
    }
  });
});
