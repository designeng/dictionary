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

        render: ->
            return (
                <form>
                    <input type="text" id="userName" name="userName" placeholder="User Name"/>
                    <input type="button" value="Start quiz" onClick={@.userEndpointRequest}/>
                </form>
            )