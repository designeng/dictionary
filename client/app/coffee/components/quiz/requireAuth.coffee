define [
    "underscore"
    "react"
    "reactRouter"
    "components/auth/index"
], (_, React, Router, auth) ->

    Route = Router.Route
    Link = Router.Link

    requireAuth = (Component) =>
        
        Authenticated = _.extend React.Component, {
            statics:
                willTransitionTo: (transition) ->
                    console.debug "auth.loggedIn()", auth.loggedIn()
                    if !auth.loggedIn()
                        transition.redirect('/login', {}, {'nextPath' : transition.path})

            # propTypes:
            #     user: React.PropTypes.instanceOf(User).isRequired

            render: ->
                return <Component {...this.props}/>
        }
            

        return Authenticated