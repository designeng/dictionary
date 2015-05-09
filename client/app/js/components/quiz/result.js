define(["underscore", "jquery", "react", "components/ajax/ajaxRequest"], function(_, $, React, AjaxRequest) {
  var Result;
  return Result = React.createClass({
    getDefaultProps: function() {
      return {
        userScorePath: "...path"
      };
    },
    componentDidMount: function() {
      return this.getUserScore();
    },
    getUserScore: function() {
      return new AjaxRequest(this.props.userScorePath, null, "GET", "application/json").always(this.onGetUserScore);
    },
    onGetUserScore: function(result) {
      return this.setState({
        score: result.score
      });
    },
    render: function() {
      var resultClass;
      resultClass = "result";
      return React.createElement("div", null, React.createElement("p", {
        "className": resultClass,
        "id": "result"
      }, "Quiz is over. Yor result: ", this.state.score));
    }
  });
});
