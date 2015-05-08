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
            @.stepBtn = $("#stepBtn")
            @.stepBtn.hide()
            @.takeStep()

        handleChange: (event) ->
            checkedInput = @.refs.quizQuestionGroup.getCheckedInput()
            @.selectedValue = checkedInput.value

            @.stepBtn.show()

        sendStepRequest: ->
            obj =
                value: @.selectedValue
            data = JSON.stringify obj
            new AjaxRequest(@.state.checkServicePath, data, "POST", "application/json").always @processAnswerResult
        
        processAnswerResult: (result) ->
            console.debug "result::::>>>>>", result

            if result.point == 0
                @.stepWarning.show()
                @.stepWarning.text "Try again"

            else
                @.stepWarning.hide()
                @.takeStep()

        takeStep: ->
            new AjaxRequest(@.state.sourceServicePath, null, "GET", "application/json").always @applyStep

        applyStep: (result) ->
            console.debug "result", result

            if @.isMounted()
                @.setState
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
                    <Choice source={this.state.choice} ref="quizQuestionGroup" onChange={this.handleChange}/>
                    <p className={stepWarningClass} id="stepWarning"></p>
                    <input type="button" value="Next" id="stepBtn" className={stepBtnClass} onClick={@.sendStepRequest}/>
                </form>
            )

    # Step = requireAuth QuizStep