define [
    "react"
    "reactRouter"
    "components/ajax/ajaxRequest"
    "./userForm"
    "./step"
    "./result"
], (React, Router, AjaxRequest, UserForm, Step, ResultHandler) ->

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
                console.debug "result:::::::::::", result

                if result.state == "INIT_USER_STATE"
                    @.context.router.transitionTo('user')
                else if result.state == "QUESTIONS_STATE"
                    @.context.router.transitionTo('questions')

            render: ->
                name = @.context.router.getCurrentPath()
                return (
                    <div>
                        <RouteHandler key={name}/>
                    </div>
                )

    routes = (
        <Route path="/" handler={App}>
            <Route name="user" path="user" handler={InitUserHandler}/>
            <Route name="questions" path="questions" handler={StepHandler}/>
            <Route name="result" path="result" handler={ResultHandler}/>
        </Route>
    )

    Router.run routes, (Handler) ->
      React.render <Handler/>, document.getElementById "application"
