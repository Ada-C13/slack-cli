# worksapce.rb
require_relative "user"
require_relative "channel"
require_relative "recipient"

module Slack_cli
  class Workspace
    attr_reader :users, :channels, :selected
  
    def initialize
      @users = Slack_cli::User.list_all
      @channels =  Slack_cli::Channel.list_all
      @selected = nil
    end

    def select_channel
      user_input = gets.chomp
      channels.each do |channel|
        if user_input == channel.name || user_input == channel.id
          @selected = channel
          return @selected.name
        end
      end
      return @selected = nil
    end

    def select_user

      user_input = gets.chomp

      users.each do |user|
        if user_input == user.real_name || user_input == user.id
          @selected = user
          return @selected.name
        end
      end
      return @selected = nil
    end

    def show_details
      @selected.details      
    end
    # Based on the channel selected.
    def send_message
      @selected.send_message(channel)
    end
  end
end

