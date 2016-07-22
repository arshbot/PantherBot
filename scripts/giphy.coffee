# Description:
#   A way to search images on giphy.com
#
# Configuration:
#   NOTICE:: Currently using the public API key for giphy!!!
#   Make sure you get a persnal one or something
#
# Commands:
#   hubot gif me <query> - Returns an animated gif matching the requested search term.

giphy =
  api_key: 'dc6zaTOxFJmzC'
  base_url: 'http://api.giphy.com/v1'

module.exports = (robot) ->
  robot.respond /(gif|giphy)( )? (.*)/i, (msg) ->
    giphyMe msg, msg.match[3], (url) ->
      msg.send url

giphyMe = (msg, query, cb) ->
  endpoint = '/gifs/search'
  url = "#{giphy.base_url}#{endpoint}"

  msg.http(url)
    .query
      q: query
      api_key: giphy.api_key
    .get() (err, res, body) ->
      response = undefined
      try
        response = JSON.parse(body)
        images = response.data
        if images.length > 0
          image = msg.random images
          cb image.images.original.url

      catch e
        response = undefined
        cb 'Error'

      return if response is undefined
