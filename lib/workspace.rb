# create, call, and use User stuff and Channel stuff from here
# but User stuff and Channel stuff are defined in their own clases

require "dotenv"
require "httparty"
require_relative "channel"
require_relative "user"
require_relative "recipient"

Dotenv.load

SLACK_TOKEN = ENV["SLACK_TOKEN"]

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_users
    @channels = Channel.list_channels

    # need to use Recipient class here???
    @selected = nil
  end

  # instance method to set and return the current workspace's selected instance variable
  def select
    puts "Enter the slack id or name:"
    user_selected = gets.chomp
    self.selected = user_selected
    return @selected
  end

  # method to validate that selected matches a valid channel or user
  def validate_selected(selected)
    # loop through all channels
      # if match is found, return true
    self.channels.each do |channel|
      return true if selected == channel["slack_id"] || selected == channel["name"]
    end

    # loop through all users
      # if match is found, return true
    self.users.each do |user|
      return true if selected == user["slack_id"] || selected == user["name"]
    end

    # if no matches found, return false
    return false
  end 
  
end
