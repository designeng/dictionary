define(["underscore", "jquery", "react", "reactRouter", "components/ajax/ajaxRequest", "./requireAuth"], function(_, $, React, Router, AjaxRequest, requireAuth) {
  var Choises, Link, Route, Step;
  Route = Router.Route;
  Link = Router.Link;
  Choises = React.createClass({
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
  return Step = React.createClass({
    getInitialState: function() {
      return {
        stepCount: 0
      };
    },
    componentDidMount: function() {
      return this.sendStepRequest();
    },
    sendStepRequest: function() {
      return new AjaxRequest(this.props.source, null, "GET", "application/json").always(this.afterSendRequest);
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
          word: result.word,
          choises: result.choises
        });
      }
      return this.state.stepCount++;
    },
    render: function() {
      return React.createElement("form", null, React.createElement("div", {
        "class": "word"
      }, this.state.word), React.createElement(Choises, {
        "source": this.state.choises
      }), React.createElement("input", {
        "type": "button",
        "value": "Next",
        "onClick": this.sendStepRequest
      }));
    }
  });
});
