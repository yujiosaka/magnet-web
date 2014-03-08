ObjectId = require('mongoose').Types.ObjectId
passport = require 'passport'
User = require 'model/user'

module.exports = (app) ->

  app.post '/register', (req, res) ->
    # Add user
    user1 = new User
      name:
        first: ""
        last: ""
      email: req.body.email
      genres: JSON.parse(req.body.genres)
      password: "password" # TOOD: password ;)
    user1.save (err, user) ->
      if err
        console.log err
        req.session.flashMessage = err.err
        res.redirect "/"
      else
        res.render "user", {message: null}

  app.get '/login', (req, res) ->
    res.render "auth/login",

  # Logging in
  app.post '/login',
    passport.authenticate('local', { successRedirect: '/', failureRedirect: '/login' })

  # Log out
  app.get '/logout', (req, res) ->
    req.logout()
    res.redirect('/')

  ## Redirect the user to Facebook for authentication.  When complete,
  ## Facebook will redirect the user back to the application at
  ##     /auth/facebook/callback
  #app.get '/auth/facebook', passport.authenticate('facebook')

  ## Facebook will redirect the user to this URL after approval.  Finish the
  ## authentication process by attempting to obtain an access token.  If
  ## access was granted, the user will be logged in.  Otherwise,
  ## authentication has failed.
  #app.get '/auth/facebook/callback', 
  #  passport.authenticate('facebook', { successRedirect: '/', failureRedirect: '/login' })

