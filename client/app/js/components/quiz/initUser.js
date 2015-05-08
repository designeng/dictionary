define(["underscore", "jquery", "react", "reactRouter", "components/ajax/ajaxRequest"], function(_, $, React, Router, AjaxRequest) {
  var InitUser, Link, Route, UserForm;
  Route = Router.Route;
  Link = Router.Link;
  UserForm = React.createClass({
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
      var controlBtnClass, controlClass, formClass, formGroupClass, inputWrapperClass;
      formClass = "form-horizontal";
      controlClass = "col-sm-2";
      controlBtnClass = "btn btn-info";
      inputWrapperClass = "col-sm-10";
      formGroupClass = "form-group";
      return React.createElement("form", {
        "className": formClass,
        "id": "userForm"
      }, React.createElement("div", {
        "className": formGroupClass
      }, React.createElement("div", {
        "className": inputWrapperClass
      }, React.createElement("input", {
        "type": "text",
        "className": controlClass,
        "value": "azxcv",
        "id": "userName",
        "name": "userName",
        "placeholder": "User Name",
        "onChange": this.onChange
      })), React.createElement("div", {
        "className": inputWrapperClass
      }, React.createElement("button", {
        "type": "button",
        "className": controlBtnClass,
        "onClick": this.userEndpointRequest
      }, "Start quiz"))));
    }
  });
  InitUser = React.createClass({
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
      })));
    }
  });
  return InitUser;
});
