require 'httparty'
require 'dotenv'
require 'pry'
require 'table_print'

Dotenv.load

module SlackApi
  class Workspace
    attr_reader :users, :channels

    def initialize(
    
    )
  
      @channels = get_channels_from_api
      @users = get_users_from_api
    
    end

    BASE_URL = "https://slack.com/api/"


    def get_users_from_api
      query_parameters = {
        token: ENV["SLACK_TOKEN"]
      }
       endpoint = BASE_URL + "users.list"
       response = HTTParty.get(endpoint, query: query_parameters)
        @users = response["members"].map do |member|
        User.new(slack_id: member["id"], name: member["name"], real_name: member["real_name"])
        end
      
    end

    def get_channels_from_api
      query_parameters = {
        token: ENV["SLACK_TOKEN"]
      }
      endpoint = BASE_URL + "channels.list"
      response = HTTParty.get(endpoint, query: query_parameters)
        @channels = response["channels"].map do |channel|
        Channel.new(slack_id: channel["id"], name: channel["name"],
        member_count: channel["members"].length, topic: channel["topic"]["value"])
        end
      
    end

    def list_all_users
      tp @users, "name", "real_name", "slack_id"
      return
    end

    def list_all_channels
      tp @channels, "name", "topic", "member_count", "slack_id"
      return 
    end

  end 
  
end 









