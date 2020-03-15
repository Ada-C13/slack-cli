# require all the things (i'm the driver class)
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
    @selected = nil
  end

  # method to update @selected if given input matches a valid channel's or user's data
  def select(recipient_data_string)
    if recipient_data_string.class != String || recipient_data_string.class == NilClass
      raise ArgumentError, "Provided input is not a string" 
    end

    self.channels.each do |channel|
      if recipient_data_string == channel.slack_id || recipient_data_string == channel.name
        @selected = channel
        return channel
      end
    end

    self.users.each do |user|
      if recipient_data_string == user.slack_id || recipient_data_string == user.name
        @selected = user
        return user
      end
    end

    return false
  end
end
