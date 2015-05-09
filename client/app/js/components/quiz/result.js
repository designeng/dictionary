define(["underscore", "jquery", "react", "./mixins/ApplicationState", "components/ajax/ajaxRequest"], function(_, $, React, ApplicationState, AjaxRequest) {
  var Result;
  return Result = React.createClass({
    mixins: [ApplicationState],
    contextTypes: {
      router: React.PropTypes.func
    },
    getDefaultProps: function() {
      return {
        userScorePath: "../api/web/v1/sessions",
        method: "GET"
      };
    },
    getInitialState: function() {
      this.getApplicationState();
      return {
        score: 0
      };
    },
    componentDidMount: function() {
      return this.getUserScore();
    },
    getUserScore: function() {
      return new AjaxRequest(this.props.userScorePath, {
        score: true
      }, this.props.method, "application/json").always(this.onGetUserScore);
    },
    onGetUserScore: function(result) {
      return this.setState({
        score: result["user_score"]
      });
    },
    btnClickHandler: function() {
      return this.context.router.transitionTo("user");
    },
    render: function() {
      var newQuizBtnClass, resultClass;
      resultClass = "bg-success result";
      newQuizBtnClass = "btn btn-info newQuizBtn";
      return React.createElement("div", null, React.createElement("p", {
        "className": resultClass,
        "id": "result"
      }, "Quiz is over. Yor result: ", this.state.score), React.createElement("input", {
        "type": "button",
        "value": "New Quiz",
        "id": "newQuizBtn",
        "className": newQuizBtnClass,
        "onClick": this.btnClickHandler
      }));
    }
  });
});
