ObjectId = require('mongoose').Types.ObjectId;
passport = require 'passport'
module.exports = (app) ->

  app.get '/login', (req, res) ->
    res.render "auth/login",
      user: req.user
      pagetype: "login"

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

