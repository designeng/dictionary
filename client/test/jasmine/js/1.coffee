<li><Step source={source}>.....</Step></li>

<ul>

<li><Link to="questions">start questions</Link></li>
                    </ul>


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

    PreStart = React.createClass
        mixins: [ AsyncElement ]
        bundle: Inbox
        preRender: ->
            return <div>PreResult here</div>