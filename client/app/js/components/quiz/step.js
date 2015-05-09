define(["underscore", "jquery", "react", "./choice", "components/ajax/ajaxRequest"], function(_, $, React, Choice, AjaxRequest) {
  var Step;
  return Step = React.createClass({
    getInitialState: function() {
      return {
        sourceServicePath: "../api/web/v1/tests",
        checkServicePath: "../api/web/v1/answers",
        stepCount: 0
      };
    },
    componentDidMount: function() {
      this.stepWarning = $("#stepWarning");
      this.stepBtn = $("#stepBtn");
      this.stepBtn.hide();
      return this.takeStep();
    },
    handleChange: function(event) {
      var checkedInput;
      checkedInput = this.refs.quizQuestionGroup.getCheckedInput();
      this.selectedValue = checkedInput.value;
      return this.stepBtn.show();
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
      console.debug("processAnswerResult:::::", result);
      if (result.point === 0) {
        this.stepWarning.show();
        return this.stepWarning.text("Try again");
      } else {
        this.stepWarning.hide();
        return this.takeStep();
      }
    },
    takeStep: function() {
      return new AjaxRequest(this.state.sourceServicePath, null, "GET", "application/json").always(this.applyStep);
    },
    applyStep: function(result) {
      console.debug("applyStep result", result);
      if (this.isMounted()) {
        this.setState({
          id: result.id,
          quizword: result.quizword,
          choice: result.choice
        });
      }
      this.state.stepCount++;
      return this.cleanPreviousChoice();
    },
    cleanPreviousChoice: function() {
      return this.refs.quizQuestionGroup.uncheck();
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
        "id": "stepBtn",
        "className": stepBtnClass,
        "onClick": this.sendStepRequest
      }));
    }
  });
});
