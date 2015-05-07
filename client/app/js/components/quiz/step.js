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
    getCheckedInput: function() {
      var $radios, res;
      $radios = this.getRadios();
      res = _.filter($radios, function(item) {
        if (item.checked) {
          return true;
        }
      });
      return res[0];
    },
    getRadios: function() {
      return this.getDOMNode().querySelectorAll('input[type="radio"]');
    },
    render: function() {
      var choiceValueClass, choises, listGroupClass, listGroupItemClass;
      listGroupClass = "list-group";
      listGroupItemClass = "list-group-item";
      choiceValueClass = "choice-value";
      choises = _.map(this.props.source, (function(_this) {
        return function(choise) {
          return React.createElement("li", {
            "className": listGroupItemClass
          }, React.createElement("input", {
            "type": "radio",
            "value": choise,
            "name": "multiChoice",
            "onChange": _this.props.onChange
          }), React.createElement("label", {
            "className": choiceValueClass
          }, choise));
        };
      })(this));
      return React.createElement("ul", {
        "className": listGroupClass
      }, choises);
    }
  });
  return Step = {
    getInitialState: function() {
      return {
        sourceServicePath: "../api/web/v1/tests",
        checkServicePath: "../api/web/v1/answers",
        stepCount: 0
      };
    },
    componentDidMount: function() {
      return this.stepWarning = $("#stepWarning");
    },
    handleChange: function(event) {
      var checkedInput;
      checkedInput = this.refs.quizQuestionGroup.getCheckedInput();
      return this.selectedValue = checkedInput.value;
    },
    sendStepRequest: function() {
      var data, obj;
      obj = {
        value: this.selectedValue
      };
      data = JSON.stringify(obj);
      return new AjaxRequest(this.state.checkServicePath, data, "POST", "application/json").always(this.processAnswerResult);
    },
    processAnswerResult: function(result) {
      console.debug("result::::>>>>>", result);
      if (result.point === 0) {
        this.stepWarning.show();
        return this.stepWarning.text("Try again");
      } else {
        this.stepWarning.hide();
        return new AjaxRequest(this.state.sourceServicePath, null, "GET", "application/json").always(this.afterSendRequest);
      }
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
      var quizwordValueClass, stepBtnClass, stepWarningClass, translateClass;
      translateClass = "bg-info quizword";
      quizwordValueClass = "quizword-value";
      stepBtnClass = "btn btn-info stepBtn";
      stepWarningClass = "bg-warning step-warning";
      return React.createElement("form", null, React.createElement("p", {
        "className": translateClass
      }, "Translate, please: ", React.createElement("span", {
        "className": quizwordValueClass
      }, this.state.quizword)), React.createElement(Choice, {
        "source": this.state.choice,
        "ref": "quizQuestionGroup",
        "onChange": this.handleChange
      }), React.createElement("p", {
        "className": stepWarningClass,
        "id": "stepWarning"
      }), React.createElement("input", {
        "type": "button",
        "value": "Next",
        "className": stepBtnClass,
        "onClick": this.sendStepRequest
      }));
    }
  };
});
