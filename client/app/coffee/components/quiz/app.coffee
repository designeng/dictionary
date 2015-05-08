define [
    "react"
    "reactRouter"
    "components/ajax/ajaxRequest"
    "./userForm"
    "./step"
    "./inbox"
], (React, Router, AjaxRequest, UserForm, Step, Inbox) ->

    Route = Router.Route
    RouteHandler = Router.RouteHandler
    Link = Router.Link

    StepHandler = React.createClass Step

    InitUserHandler = React.createClass

        render: ->
            panelClass = "panel panel-default"
            panelBodyClass = "panel-body"
            panelTitleClass = "panel-title"
            panelHeadingClass = "panel-heading"

            console.debug "render InitUserHandler"

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


    App = React.createClass

            contextTypes:
                router: React.PropTypes.func

            componentDidMount: ->
                @.getState()

            getState: ->
                stateServicePath = "../api/web/v1/states"
                new AjaxRequest(stateServicePath, null, "GET", "application/json").always @onGetState

            onGetState: (result) ->
                if result.state == "INIT_USER_STATE"
                    @.context.router.transitionTo('user')
                else if result.state == "QUESTIONS_STATE"
                    @.context.router.transitionTo('questions')

            render: ->
                return (
                    <div></div>
                )

    routes = (
      <Route path="/" handler={App}>
        <Route name="user" path="user" handler={InitUserHandler}>
            <InitUserHandler />
        </Route>
        <Route name="questions" path="questions" handler={StepHandler}></Route>
        <Route name="result" path="questions/result"/>
      </Route>
    )

    Router.run routes, (Handler) ->
      React.render <Handler/>, document.getElementById "application"
