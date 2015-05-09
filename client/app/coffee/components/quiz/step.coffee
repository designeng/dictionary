define [
    "underscore"
    "jquery"
    "react"
    "./choice"
    "components/ajax/ajaxRequest"
], (_, $, React, Choice, AjaxRequest) ->

    Step = React.createClass

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
            @.buttonEnableState(true)

            checkedInput = @.refs.quizQuestionGroup.getCheckedInput()
            @.selectedValue = checkedInput.value

            @.stepBtn.show()

        sendStepRequest: ->
            obj =
                value: @.selectedValue
            data = JSON.stringify obj
            new AjaxRequest(@.state.checkServicePath, data, "POST", "application/json").always @processAnswerResult
        
        processAnswerResult: (result) ->
            console.debug "processAnswerResult:::::", result

            if result.point == 0
                @.stepWarning.show()
                @.stepWarning.text "Try again"

            else
                @.stepWarning.hide()
                @.takeStep()

        takeStep: ->
            new AjaxRequest(@.state.sourceServicePath, null, "GET", "application/json").always @applyStep

        applyStep: (result) ->
            console.debug "applyStep result:::::", result

            if @.isMounted()
                @.setState
                    id: result.id
                    quizword: result.quizword
                    choice: result.choice

            @.state.stepCount++

            @.cleanPreviousChoice()

            @.buttonEnableState(false)

        cleanPreviousChoice: ->
            @.refs.quizQuestionGroup.uncheck()

        buttonEnableState: (state) ->
            if !state
                @.stepBtn.attr("disabled", "disabled")
            else
                @.stepBtn.removeAttr("disabled")

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