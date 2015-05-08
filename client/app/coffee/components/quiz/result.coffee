define [
    "underscore"
    "jquery"
    "react"
    "reactRouter"
    "components/ajax/ajaxRequest"
], (_, $, React, Router, AjaxRequest) ->

    Route = Router.Route
    Link = Router.Link

    Result = React.createClass

        componentDidMount: ->

        render: ->
            resultClass = "result"
            return (
                <div className={resultClass}>RESULT</div>
            )