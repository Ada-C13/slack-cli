require 'HTTParty'
require 'dotenv'
require 'table_print'
require_relative 'slack'
require_relative 'channel'
require_relative 'user'
require_relative 'recipient'

Dotenv.load

module Slack
class Workspace 

  attr_reader :users, :channels, :selected

  def initialize 
    @users = [] # User.list_all
    @channels = [] #Channel.list_all
    @selected = nil
  end


#   def select_channel
#   end

  # def select_user
  # end

  # def show_details 
  # end

  # def send_message 
  # end


  # def list_users
  #   query = {
  #     token: ENV["SLACK_API_TOKEN"]
  #   }

  #   url = "https://slack.com/api/users.list"
  #   response = HTTParty.get(url, query: query)
  #   #  puts response 
  #   response["members"].each do |user|
  #     puts "User info:
  #       username: #{user["name"]}, 
  #       real name: #{user["real_name"]}, 
  #       id: #{user["id"]}"
  #   end 
  # end

  # def list_channels
  #   query = {
  #     token: ENV["SLACK_API_TOKEN"]
  #   }
    
  #   url = "https://slack.com/api/channels.list"
  #   response = HTTParty.get(url, query: query)
    
  #   response["channels"].each do |channel|
  #     puts "Channel info:
  #       name: #{channel["name"]},
  #       topic: #{channel["topic"]["value"]},
  #       member count: #{channel["num_members"]},
  #       id: #{channel["id"]},
  #       "
  #   end 
  # end

end
end