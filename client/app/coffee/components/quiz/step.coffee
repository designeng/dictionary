define [
    "underscore"
    "jquery"
    "react"
    "reactRouter"
    "signals"
    "components/ajax/ajaxRequest"
    "./requireAuth"
], (_, $, React, Router, Signal, AjaxRequest, requireAuth) ->

    Route = Router.Route
    Link = Router.Link

    Choice = React.createClass

        getInitialState: ->
            return {value: 'celery'}

        getCheckedInput: ->
            $radios = @.getRadios()

            res = _.filter $radios, (item) ->
                if item.checked
                    return true

            return res[0]

        getRadios: ->
            return @.getDOMNode().querySelectorAll('input[type="radio"]')

        render: ->
            listGroupClass = "list-group"
            listGroupItemClass = "list-group-item"
            choiceValueClass = "choice-value"

            choises = _.map @.props.source, (choise) =>
                return <li className={listGroupItemClass}><input type="radio" value={choise} name="multiChoice" onChange={@.props.onChange}/><label className={choiceValueClass}>{choise}</label></li>

            return (
                <ul className={listGroupClass}>{choises}</ul>
            )

    Step = 
        getInitialState: ->
            return {
                sourceServicePath: "../api/web/v1/tests"
                checkServicePath: "../api/web/v1/answers"
                stepCount: 0
            }

        componentDidMount: ->
            @.stepWarning = $("#stepWarning")
            @.signal = new Signal()
            @.signal.add (event) ->
                console.debug "event....", event
            
            @.onChange = (event) ->
                console.debug "onChange::::", event

            @.onClick = (event) ->
                console.debug "onClick::::", event

            @sendStepRequest()

        handleChange: (event) ->
            checkedInput = @.refs.quizQuestionGroup.getCheckedInput()
            @.selectedValue = event.target.value

        sendStepRequest: ->
            new AjaxRequest(@.state.checkServicePath, {value: @.selectedValue}, "POST", "application/json").always @processAnswerResult
        
        processAnswerResult: (result) ->
            console.debug "result::::", result

            if result.point == 0
                @.stepWarning.show()
                @.stepWarning.text "Try again"
                console.debug "Try again"

            else
                @.stepWarning.hide()
                new AjaxRequest(@.state.sourceServicePath, null, "GET", "application/json").always @afterSendRequest

        afterSendRequest: (result) ->
            console.debug "result", result

            result.choises = _.map result.choises, (item) =>
                return item + "_" + @.state.stepCount

            if @.isMounted()
                this.setState
                    id: result.id
                    quizword: result.quizword
                    choice: result.choice

            @.state.stepCount++

        render: ->
            translateClass = "bg-info quizword"
            quizwordValueClass = "quizword-value"
            stepBtnClass = "btn btn-info stepBtn"
            stepWarningClass = "bg-warning step-warning"

            return (
                <form>
                    <p className={translateClass}>Translate, please: <span className={quizwordValueClass}>{this.state.quizword}</span></p>
                    <Choice source={this.state.choice} signal={this.signal} ref="quizQuestionGroup" onChange={this.handleChange}/>
                    <p className={stepWarningClass} id="stepWarning"></p>
                    <input type="button" value="Next" className={stepBtnClass} onClick={@.sendStepRequest}/>
                </form>
            )

    # Step = requireAuth QuizStep