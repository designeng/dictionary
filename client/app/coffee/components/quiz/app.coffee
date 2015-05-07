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
                $("#userForm").show()

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
