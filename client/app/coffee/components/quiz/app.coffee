define [
    "react"
    "reactRouter"
    "./userForm"
    "./step"
    "./inbox"
], (React, Router, UserForm, Step, Inbox) ->

    Route = Router.Route
    RouteHandler = Router.RouteHandler
    Link = Router.Link

    StepHandler = React.createClass Step

    App = React.createClass
            componentDidMount: ->
                console.debug "....."
                $("#userForm").show()

            render: ->
                return (
                    <div>
                        <h1>Dictionary Test</h1>
                        <UserForm endpoint="../api/web/v1/sessions" onsuccess="questions"/>
                        <RouteHandler/>
                    </div>
                )

    routes = (
      <Route path="/" handler={App}>
        <Route name="questions" path="questions" handler={StepHandler}>
        </Route>
        <Route name="result" path="questions/result"/>
      </Route>
    )

    Router.run routes, (Handler) ->
      React.render <Handler/>, document.getElementById "application"
