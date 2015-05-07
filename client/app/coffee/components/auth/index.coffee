# authentication lib
define ->

    pretendRequest = (email, pass, cb) ->
        setTimeout () ->
            if email == 'joe@example.com' and pass == 'password1'
                cb({
                    authenticated: true
                    token: Math.random().toString(36).substring(7)
                })
            else
              cb({authenticated: false})
        , 0

    auth =
        login: (email, pass, cb) ->
            if localStorage.token
                cb(true) if cb?
                @.onChange(true)
                return

            pretendRequest email, pass, (res) =>
                if res.authenticated
                    localStorage.token = res.token
                    cb(true) if cb?
                    this.onChange(true)
                else
                    cb(false) if cb?
                    @.onChange(false)

        getToken: () ->
            return localStorage.token

        logout: (cb) ->
            delete localStorage.token
            cb(true) if cb?
            @.onChange(false)

        loggedIn: ->
            return !!localStorage.token

        onChange: () ->
