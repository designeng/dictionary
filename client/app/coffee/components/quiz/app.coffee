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

    AsyncElement =
        loadedComponent: null

        load: ->
            if @.constructor.loadedComponent
                return

            @.bundle (component) =>
                @.constructor.loadedComponent = component
                @.forceUpdate()

        componentDidMount: () ->
            setTimeout(@.load, 1000)

        render: () ->
            Component = @.constructor.loadedComponent
            if (Component)
                @.props.activeRoute = <RouteHandler/>
                return <Component {...@.props}/>
            return @.preRender()

    PreQuestions = React.createClass
        mixins: [ AsyncElement ]
        bundle: Step
        preRender: () ->
            return <div>Loading questions...</div>


    PreResult = React.createClass
        mixins: [ AsyncElement ]
        bundle: Inbox
        preRender: ->
            return <div>PreResult here</div>

    App = React.createClass
        render: ->
            return (
                <div>
                    <h1>Dictionary Test</h1>
                    <UserForm endpoint="../api/web/v1/sessions"/>
                    <ul>
                        <li><Link to="questions">start questions</Link></li>
                    </ul>
                    <RouteHandler/>
                </div>
            )

    routes = (
      <Route handler={App}>
        <Route name="questions" path="questions" handler={PreQuestions}>
          <Route name="result" path="questions/result" handler={PreResult}/>
        </Route>
      </Route>
    )

    Router.run routes, (Handler) ->
      React.render <Handler/>, document.getElementById "application"
