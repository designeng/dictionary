define(["underscore", "jquery", "react", "reactRouter", "components/ajax/ajaxRequest", "./requireAuth"], function(_, $, React, Router, AjaxRequest, requireAuth) {
  var Choice, Link, Route, Step;
  Route = Router.Route;
  Link = Router.Link;
  Choice = React.createClass({
    getInitialState: function() {
      return {
        value: 'celery'
      };
    },
    handleChange: function(event) {
      return console.debug("onChangeHandler:::", event.target);
    },
    render: function() {
      var choises;
      choises = _.map(this.props.source, function(choise) {
        return React.createElement("label", null, React.createElement("input", {
          "type": "radio",
          "value": "choise"
        }), choise);
      });
      return React.createElement("div", null, choises);
    }
  });
  return Step = {
    getInitialState: function() {
      return {
        source: "../api/web/v1/tests",
        stepCount: 0
      };
    },
    componentDidMount: function() {
      console.debug("componentDidMount");
      return this.sendStepRequest();
    },
    sendStepRequest: function() {
      return new AjaxRequest(this.state.source, null, "GET", "application/json").always(this.afterSendRequest);
    },
    afterSendRequest: function(result) {
      console.debug("result", result);
      result.choises = _.map(result.choises, (function(_this) {
        return function(item) {
          return item + "_" + _this.state.stepCount;
        };
      })(this));
      if (this.isMounted()) {
        this.setState({
          id: result.id,
          quizword: result.quizword,
          choice: result.choice
        });
      }
      return this.state.stepCount++;
    },
    render: function() {
      return React.createElement("form", null, React.createElement("div", {
        "class": "word"
      }, this.state.quizword), React.createElement(Choice, {
        "source": this.state.choice
      }), React.createElement("input", {
        "type": "button",
        "value": "Next",
        "onClick": this.sendStepRequest
      }));
    }
  };
});
