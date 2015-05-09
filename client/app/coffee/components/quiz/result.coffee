define [
    "underscore"
    "jquery"
    "react"
    "components/ajax/ajaxRequest"
], (_, $, React, AjaxRequest) ->

    Result = React.createClass

        getDefaultProps: ->
            userScorePath: "...path"

        componentDidMount: ->
            @.getUserScore()

        getUserScore: ->
            new AjaxRequest(@.props.userScorePath, null, "GET", "application/json").always @onGetUserScore

        onGetUserScore: (result) ->
            @.setState
                score: result.score

        render: ->
            resultClass = "result"
            return (
                <div>
                    <p className={resultClass} id="result">Quiz is over. Yor result: {@.state.score}</p>
                </div>
            )