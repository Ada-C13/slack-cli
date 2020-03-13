require_relative "user"
require_relative "channel"

module Slack 
  class Workspace 

    attr_reader :users, :channels, :selected

    def initialize
      @users = Slack::User.list_all
      @channels = Slack::Channel.list_all
      @selected = nil
    end


    # Question: Do I need this?
    # (1) I should see information about how many channels and users were loaded  => [].length
    def num_of_users 
      @users.length
    end 

    def num_of_channels 
      @channels.length
    end 


    # When I type select user, I should be able to supply a username or Slack ID. The corresponding user should be the "selected" recipient.
    def select_user(user_input) 
      @selected = @users.find { |user| (user.name == user_input) || (user.slack_id == user_input) || () || (user.real_name == user_input)}

      return @selected
    end 

    # When I type select channel, I should be able to supply a channel name or Slack ID. The corresponding channel should be the "selected" recipient.
    def select_channel(user_input) 
      @selected = @channels.find { |channel| (channel.name == user_input) || channel.slack_id == user_input}

      return @selected
    end 

    def show_details 
      @selected.details if @selected

      # tp @selected, [*@selected.details.keys] if @selected
    end 

    def send_message 
    end 
  end 
end 