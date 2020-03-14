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

  # method to validate that selected matches a valid channel or user
  def validate_selected(user_selected)
    if user_selected.class != String || user_selected.class == NilClass
      raise ArgumentError, "Provided input is not a string" 
    end

    self.channels.each do |channel|
      return true if user_selected == channel.slack_id || user_selected == channel.name
    end

    self.users.each do |user|
      return true if user_selected == user.slack_id || user_selected == user.name
    end

    return false
  end 

  # instance method to set and return the current workspace's selected instance variable
  def update_select(selected)
    self.selected = selected
    return @selected
  end
  
end
