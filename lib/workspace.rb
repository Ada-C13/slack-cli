require_relative 'user'
require_relative 'channel'

Dotenv.load 
URL_CHANNEL = "https://slack.com/api/conversations.list"
URL_USER = "https://slack.com/api/users.list"

TOKEN = ENV["SLACK_API_TOKEN"]


class Workspace

  attr_reader :users, :channels
  
  def initialize
    @users = User.get(URL_USER,{token:TOKEN})
    @channels = Channel.get(URL_CHANNEL,{token:TOKEN})

  
  end

end