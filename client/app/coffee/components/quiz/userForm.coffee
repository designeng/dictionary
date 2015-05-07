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
            return (
                <form id="userForm">
                    <input type="text" value="azxcv" id="userName" name="userName" placeholder="User Name" onChange={@.onChange}/>
                    <input type="button" value="Start quiz" onClick={@.userEndpointRequest}/>
                </form>
            )