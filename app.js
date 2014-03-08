
/**
 * Module dependencies.
 */

var coffee = require('coffee-script/register');
var express = require('express');
var http = require('http');
var path = require('path');
var mongoose = require('mongoose'),
    MongoStore = require('connect-mongo')(express); // For session
var passport = require('passport');
var sass = require('node-sass');
var app = express();

//var sessionStore = new MongoStore({
//  mongoose_connection: mongoose.connections[0],
//  clear_interval: 24*60*60 /* In seconds!! */
//});

// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
app.use(express.favicon('public/images/favicon.ico'));
app.use(express.cookieParser());
app.use(express.logger('dev'));
app.use(express.json());
app.use(express.urlencoded());
app.use(express.methodOverride());
app.use(passport.initialize());
app.use(passport.session());
app.use(app.router);
app.use(
    sass.middleware({
    src: __dirname + '/assets', //where the sass files are 
    dest: __dirname + '/public', //where css should go
    debug: true // obvious
}));
app.use(express.static(path.join(__dirname, 'public')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

require("./lib/routes")(app)

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
