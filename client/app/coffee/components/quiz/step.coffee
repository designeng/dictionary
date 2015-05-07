define [
    "underscore"
    "jquery"
    "react"
    "reactRouter"
    "components/ajax/ajaxRequest"
    "./requireAuth"
], (_, $, React, Router, AjaxRequest, requireAuth) ->

    Route = Router.Route
    Link = Router.Link

    Choises = React.createClass

        getInitialState: ->
            return {value: 'celery'}

        handleChange: (event) ->
            console.debug "onChangeHandler:::", event.target

        render: ->
            choises = _.map @.props.source, (choise) ->
                return <label><input type="radio" value="choise"/>{choise}</label>

            return (
                <div>{choises}</div>
            )

    # return Choises

    # <Step source="/api/step"></Step>
    # result: {JSON} - ex: {id: "...", word: "....", choises: [....]}

    Step = React.createClass
        getInitialState: ->
            return {
                stepCount: 0
            }

        componentDidMount: ->
            @sendStepRequest()

        sendStepRequest: ->
            new AjaxRequest(@.props.source, null, "GET", "application/json").always @afterSendRequest

        afterSendRequest: (result) ->
            console.debug "result", result

            result.choises = _.map result.choises, (item) =>
                return item + "_" + @.state.stepCount

            if @.isMounted()
                this.setState
                    id: result.id
                    word: result.word
                    choises: result.choises

            @.state.stepCount++

        render: ->
            return (
                <form>
                    <div class="word">{this.state.word}</div>
                    <Choises source={this.state.choises}/>
                    <input type="button" value="Next" onClick={@.sendStepRequest}/>
                </form>
            )

    # class QuizStep extends React.Component
    #     render: ->
    #         return (
    #             <div>
    #                 <h1>Step 1</h1>
    #                 <ul>
    #                     <li><Link to="result">Step-QUESTION-result</Link></li>
    #                 </ul>
    #                 <RouteHandler/>
    #             </div>
    #         )


    # Step = requireAuth QuizStep