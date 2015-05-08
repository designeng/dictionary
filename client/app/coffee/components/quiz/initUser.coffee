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

        componentDidMount: ->
            $("#userForm").show()

        onChange: ->

        validateForm: ->
            userName = $.trim($("#userName").val())
            if !userName
                alert "Input userName!"
                return false
            return true

        userEndpointRequest: ->
            if @.validateForm()
                new AjaxRequest(@.props.endpoint, null, "GET", "application/json").always @afterSendRequest

        afterSendRequest: (result) ->
            console.debug "result", result

            if @.isMounted()
                this.setState
                    id: result.id
                    word: result.word
                    choises: result.choises

            if result? and !result.error

                window.location.hash = "questions"
                $("#userForm").hide()

        render: ->
            formClass = "form-horizontal"
            controlClass = "col-sm-2"
            controlBtnClass = "btn btn-info"
            inputWrapperClass = "col-sm-10"
            formGroupClass = "form-group"
            return (
                <form className={formClass} id="userForm">
                    <div className={formGroupClass}>
                        <div className={inputWrapperClass}>
                            <input type="text" className={controlClass} value="azxcv" id="userName" name="userName" placeholder="User Name" onChange={@.onChange}/>
                        </div>
                        <div className={inputWrapperClass}>
                            <button type="button" className={controlBtnClass} onClick={@.userEndpointRequest}>Start quiz</button>
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
                        <UserForm endpoint="../api/web/v1/sessions" onsuccess="questions"/>
                    </div>
                </div>
            )

    return InitUser