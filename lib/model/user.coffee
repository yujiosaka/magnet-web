mongoose = require 'mongoose'

passport = require('passport')
bcrypt = require('bcrypt')

# Define schema for our own users
UserSchema = new mongoose.Schema
  name:
    first: { type: String, required: true }
    last: { type: String, required: true }
  email: { type: String, required: true, unique: true }

  salt: { type: String, required: true }
  hash: { type: String, required: true }

  accounts: []

# virtual password function
UserSchema.virtual('password')
  .get () ->
    return @_password
  .set (password) ->
    @_password = password
    salt = @salt = bcrypt.genSaltSync(10)
    @hash = bcrypt.hashSync(password, salt)

# verify password
UserSchema.method 'verifyPassword', (password, callback) ->
  bcrypt.compare(password, this.hash, callback)

# authenticate
UserSchema.static 'authenticate', (email, password, callback) ->
  #console.log "Authenticating: " + email
  User.findOne({ "email": email }, (err, user) ->
    return callback(err) if (err)
    return callback(null, false) if (!user)
    user.verifyPassword password, (err, passwordCorrect) ->
      return callback(err) if (err)
      return callback(null, false) if (!passwordCorrect)

      # Was OK
      return callback(null, user)
  )

User = mongoose.model("User", UserSchema)

# Define local strategy for Passport
LocalStrategy = require('passport-local').Strategy

passport.use new LocalStrategy {
    usernameField: 'email'
  },
  (email, password, done) ->
    User.authenticate email, password, (err, user) ->
      return done(err, user)
      
# serialize user on login
passport.serializeUser (user, done) ->
  done(null, user.id)

# deserialize user on logout
passport.deserializeUser (id, done) ->
  User.findById id, (err, user) ->
    done(err, user)


module.exports = User
