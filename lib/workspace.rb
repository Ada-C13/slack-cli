require "httparty"
require "dotenv"
require_relative "channel"
require_relative "user"
# Dotenv.load
# URL = "https://slack.com/api/channels.list"
# AUTH_TOKEN = ENV["SLACK_TOKEN"]

# query = {
#   token: AUTH_TOKEN,
# }

# response = HTTParty.get(URL, query: query)
# response["channels"].each do |channel|
#   ap channel["name"]
# end

# # unless response.code == 200
# #   raise(ArgumentError, "what is happening")
# # end

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
  end

  

end
