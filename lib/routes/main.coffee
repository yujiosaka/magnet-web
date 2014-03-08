module.exports = (app) ->

  app.get '/', (req, res) ->
    res.render "index",
      title: "Magnet"
      genres:
        development: '開発',
        design: 'デザイン',
        writing: 'ライティング'
        office: '事務'
