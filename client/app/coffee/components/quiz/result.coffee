define [
    "underscore"
    "jquery"
    "react"
    "components/ajax/ajaxRequest"
], (_, $, React, AjaxRequest) ->

    Result = React.createClass

        componentDidMount: ->

        render: ->
            resultClass = "result"
            return (
                <div className={resultClass}>RESULT</div>
            )