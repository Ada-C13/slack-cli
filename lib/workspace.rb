require 'httparty'
require 'dotenv'

BASE_URL = "https://slack.com/api/"

Dotenv.load

class Workspace

  attr_reader :users, :channenls

  def initialize
    @users = []
    @channels = list_channels

  end 
  def list_users

    query = {
      token:  ENV["SLACK_TOKEN"]
    }
    response = HTTParty.get(BASE_URL + "users.list", query: query)

  end
  def list_channels 
    query = {
      token: ENV["SLACK_TOKEN"]
    }
    response = HTTParty.get(BASE_URL + "conversations.list", query: query)
    return response
  end 
  



end 

# def main 

#   workspace = Workspace.new()
#   puts workspace.list_channels()

# end 

# main 