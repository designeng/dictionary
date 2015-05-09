define [
    "underscore"
    "jquery"
    "react"
    "reactRouter"
    "components/ajax/ajaxRequest"
], (_, $, React, Router, AjaxRequest) ->

    Route = Router.Route
    Link = Router.Link

    UserForm = React.createClass

        contextTypes:
            router: React.PropTypes.func

        componentDidMount: ->
            $("#userForm").show()

        validateForm: ->
            userName = $.trim($("#userName").val())
            if !userName
                alert "Input userName!"
                return false
            return userName

        clickHandler: ->
            userName = @.validateForm()
            if userName
                data = JSON.stringify
                    username: userName
                @.userEndpointRequest(data)

        onChangeHandler: ->
            return true

        onSubmit: ->
            @.clickHandler()
            return false

        userEndpointRequest: (data) ->
            new AjaxRequest(@.props.endpoint, data, @.props.method, "application/json").always @afterSendRequest

        afterSendRequest: (result) ->
            if @.isMounted()
                this.setState
                    id: result.id
                    word: result.word
                    choises: result.choises

            if result? and !result.error
                @.context.router.transitionTo(@.props.next)
                $("#userForm").hide()
            return false

        render: ->
            formClass = "form-horizontal"
            controlClass = "col-sm-2"
            controlBtnClass = "btn btn-info"
            inputWrapperClass = "col-sm-10"
            formGroupClass = "form-group"

            return (
                <form className={formClass} id="userForm" onSubmit={@.onSubmit}>
                    <div className={formGroupClass}>
                        <div className={inputWrapperClass}>
                            <input type="text" className={controlClass} id="userName" name="userName" placeholder="User Name" onChange={@.onChangeHandler}/>
                        </div>
                        <div className={inputWrapperClass}>
                            <button type="button" id="userFormBtn" className={controlBtnClass} onClick={@.clickHandler}>Start quiz</button>
                        </div>
                    </div>
                </form>
            )

    InitUser = React.createClass

        render: ->
            panelClass = "panel panel-default"
            panelBodyClass = "panel-body"
            panelTitleClass = "panel-title"
            panelHeadingClass = "panel-heading"

            return (
                <div className={panelClass}>
                    <div className={panelHeadingClass}>
                        <h3 className={panelTitleClass}>Dictionary Quiz</h3>
                    </div>
                    <div className={panelBodyClass}>
                        <UserForm endpoint="../api/web/v1/sessions" method="POST" next="questions"/>
                    </div>
                </div>
            )

    return InitUser