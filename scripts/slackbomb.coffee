# Description:
#   Tell Hubot to send a user a message right now !
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot im <username> <some message> - im <username> <some message> right now !
#
# Author:
#   arshbot
#
# Additional Requirements
#   Only works on gtalk

module.exports = (robot) ->
  robot.respond /(\w+)bomb (@\w+)/i, (msg) ->
   new_user =
    name: msg.match[2]
    user: msg.match[2]
    type: "chat"

   robot.send new_user, msg.match[2]

   bomb = (animal, new_user)  ->
    #animal bomb code here

    SlackClient = require('slack-api-client')
    slack = new SlackClient('token')

    x for x in [1..10]
      #for loop that executes 100x
      slack.api.chat.postMessage {
        channel: new_user.name
        username: 'pantherbot''
        text: 'Hello world!'
      }, (err, res) ->
        if err
        throw err
        console.log res
        return



###
module.exports = (robot) ->
  robot.respond /im ([\w.-@]*) (.*)/i, (msg) ->
   new_user =
    id: msg.match[1] + "@" + msg.message.user.domain
    name: msg.match[1]
    user: msg.match[1]
    type: "chat"

   robot.send new_user, msg.match[2]
###

