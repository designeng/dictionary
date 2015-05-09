define [
    "underscore"
    "jquery"
    "react"
    "./mixins/ApplicationState"
    "components/ajax/ajaxRequest"
], (_, $, React, ApplicationState, AjaxRequest) ->

    Result = React.createClass

        mixins: [ApplicationState]

        contextTypes:
            router: React.PropTypes.func

        getDefaultProps: ->
            userScorePath: "../api/web/v1/sessions"
            method: "GET"

        getInitialState: ->
            # @.getApplicationState()
            return {
                score: 0
            }

        componentDidMount: ->
            @.getUserScore()

        getUserScore: ->
            new AjaxRequest(@.props.userScorePath, {score: true}, @.props.method, "application/json").always @onGetUserScore

        onGetUserScore: (result) ->
            @.setState
                score: result["user_score"]

        btnClickHandler: ->
            @.context.router.transitionTo("user")

        render: ->
            resultClass = "bg-success result"
            newQuizBtnClass = "btn btn-info newQuizBtn"
            return (
                <div>
                    <p className={resultClass} id="result">Quiz is over. Yor result: {@.state.score}</p>
                    <input type="button" value="New Quiz" id="newQuizBtn" className={newQuizBtnClass} onClick={@.btnClickHandler}/>
                </div>
            )