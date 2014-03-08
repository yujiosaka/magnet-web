fs = require('fs')

module.exports = (app) ->
  fs.readdirSync(__dirname).forEach (file) ->
    #return if (file == "index.js")
    return if (file == "index.coffee")
    return if !/(.coffee)$/.test(file)
    name = file.substr(0, file.indexOf('.'))
    require('./' + name)(app)
