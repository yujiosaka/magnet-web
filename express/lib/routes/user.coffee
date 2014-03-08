ObjectId = require('mongoose').Types.ObjectId
passport = require 'passport'
User = require '../model/user'

RakutenStrategy = require('passport-rakuten').RakutenStrategy

strat = new RakutenStrategy({
    clientID     : Magnet.rakuten_app_id,
    clientSecret : Magnet.rakuten_app_secret,
    callbackURL  : "auth/rakuten/callback"
}, (accessToken, refreshToken, profile, done) ->
  # With this accessToken you can access user profile data.
  # In the case that accessToken is expired, you should 
  # regain it with refreshToken. So you have to keep these token
  # safely. done will get user profile data such as openid in YConnect   
  console.log("HERRERERERE")
  console.log(accessToken)
  console.log(refreshToken)
  console.log(profile)
  done()
)

# Define local strategy for Passport
LocalStrategy = require('passport-local').Strategy

passport.use new LocalStrategy {
    usernameField: 'email'
  },
  (email, password, done) ->
    User.authenticate email, password, (err, user) ->
      return done(err, user)

passport.use strat

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
        req.session.message = err.err
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

  app.get '/auth/rakuten', passport.authenticate('rakuten')

  app.get '/auth/rakuten/callback',
    passport.authenticate('rakuten', { successRedirect: '/', failureRedirect: '/login' })

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

