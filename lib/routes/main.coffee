module.exports = (app) ->

  app.get '/', (req, res) ->
    res.render "index",
      genres: Magnet.genres
      message: req.session.message
    req.session.message = undefined
