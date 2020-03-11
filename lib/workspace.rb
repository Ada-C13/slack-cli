
require 'dotenv'
require 'httparty'
Dotenv.load

KEY = ENV["SLACK_TOKEN"]

#module Slack
  class Workspace
  attr_reader :channels, :users
    def initialize
      @channels = []
      @users = []
    end

    def num_of_channels
      channels_url = "https://slack.com/api/conversations.list"
      response = HTTParty.get(channels_url, query: {token: KEY})
      number = response["channels"].count
      return number
    end
    
    def num_of_users
      users_url = "https://slack.com/api/users.list"
      response = HTTParty.get(users_url, query: {token: KEY})
      number = response["members"].count
      return number
    end
    

  end

#end