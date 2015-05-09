define [
    "underscore"
    "jquery"
    "react"
    "./choice"
    "components/ajax/ajaxRequest"
], (_, $, React, Choice, AjaxRequest) ->

    Step = React.createClass

        contextTypes:
            router: React.PropTypes.func

        getInitialState: ->
            return {
                attempts: []
                maxAttempsCount: 2
                stepCount: 0
            }

        getDefaultProps: ->
            return {
                resultRoutePath: "result"
                stepServicePath: "../api/web/v1/steps"
                checkAnswerServicePath: "../api/web/v1/answers"
            }

        componentDidMount: ->
            @.stepWarning = $("#stepWarning")
            @.stepWarning.hide()

            @.stepBtn = $("#stepBtn")
            @.stepBtn.hide()

            @.takeStep()

        handleChange: (event) ->
            @.buttonEnableState(true)

            checkedInput = @.refs.quizQuestionGroup.getCheckedInput()
            @.selectedValue = checkedInput.value

            @.stepBtn.show()

        btnClickHandler: ->
            console.debug "btnClickHandler........", @state.attempts

            @.sendStepRequest()
            @.registerAttempt()

        registerAttempt: ->
            @.state.attempts.push 1

        resetStepAttempts: ->
            @.state.attempts = []

        sendStepRequest: ->
            obj =
                value: @.selectedValue
            data = JSON.stringify obj
            new AjaxRequest(@.props.checkAnswerServicePath, data, "POST", "application/json").always @processAnswerResult
        
        processAnswerResult: (result) ->
            console.debug "processAnswerResult:::::", result

            $("#userScore").text result.user_score
            $("#userMistakes").text result.mistakes_count

            if result.state == "QUIZ_END_WITH_MISTAKES"
                return @.context.router.transitionTo(@.props.resultRoutePath)
            
            # success answer
            if result.point == 1
                return @.next()
            # unsuccess answer
            else
                @.stepWarning.show()

                if @.state.attempts.length < @.state.maxAttempsCount
                    @.stepWarning.text "Wrong answer! Try once more"
                    @.cleanPreviousChoice()
                else
                    return @.next()

        next: ->
            @.stepWarning.hide()
            @.resetStepAttempts()
            @.takeStep()

        takeStep: ->
            new AjaxRequest(@.props.stepServicePath, null, "GET", "application/json").always @applyStep

        applyStep: (result) ->
            if result.state == "QUIZ_END_WORDS"
                return @.context.router.transitionTo(@.props.resultRoutePath)

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
                    <div id="userScore">...</div>
                    <div id="userMistakes">---</div>
                    <p className={translateClass}>Translate, please: <span className={quizwordValueClass}>{this.state.quizword}</span></p>
                    <Choice source={this.state.choice} ref="quizQuestionGroup" onChange={this.handleChange}/>
                    <p className={stepWarningClass} id="stepWarning"></p>
                    <input type="button" value="Next" id="stepBtn" className={stepBtnClass} onClick={@.btnClickHandler}/>
                </form>
            )