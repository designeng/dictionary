define(function() {
  var auth, pretendRequest;
  pretendRequest = function(email, pass, cb) {
    return setTimeout(function() {
      if (email === 'joe@example.com' && pass === 'password1') {
        return cb({
          authenticated: true,
          token: Math.random().toString(36).substring(7)
        });
      } else {
        return cb({
          authenticated: false
        });
      }
    }, 0);
  };
  return auth = {
    login: function(email, pass, cb) {
      if (localStorage.token) {
        if (cb != null) {
          cb(true);
        }
        this.onChange(true);
        return;
      }
      return pretendRequest(email, pass, (function(_this) {
        return function(res) {
          if (res.authenticated) {
            localStorage.token = res.token;
            if (cb != null) {
              cb(true);
            }
            return _this.onChange(true);
          } else {
            if (cb != null) {
              cb(false);
            }
            return _this.onChange(false);
          }
        };
      })(this));
    },
    getToken: function() {
      return localStorage.token;
    },
    logout: function(cb) {
      delete localStorage.token;
      if (cb != null) {
        cb(true);
      }
      return this.onChange(false);
    },
    loggedIn: function() {
      return !!localStorage.token;
    },
    onChange: function() {}
  };
});
