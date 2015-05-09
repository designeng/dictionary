define [
    "react"
    "reactRouter"
    "components/ajax/ajaxRequest"
    "./initUser"
    "./step"
    "./result"
], (React, Router, AjaxRequest, InitUserHandler, StepHandler, ResultHandler) ->

    Route = Router.Route
    RouteHandler = Router.RouteHandler
    
    Link = Router.Link

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

    Router.run routes, (Root) ->
        React.render <Root/>, document.getElementById "application"
