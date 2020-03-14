require_relative "user"
require_relative "channel"
require "table_print"

module Slack 
  class Workspace 

    attr_reader :users, :channels, :selected

    def initialize
      @users = Slack::User.list_all
      @channels = Slack::Channel.list_all
      @selected = nil
    end

    # reference: http://tableprintgem.com/

    # Question
    # Is it good to put in "slack.rb" or "workspace.rb?
    def list_users 
      tp @users, :name, :real_name, :slack_id
    end 

    def list_channels 
      tp @channels, :name, :topic, :member_count, :slack_id
    end 

    def select_user(user_input) 
      @selected = @users.find { |user| (user.name == user_input) || (user.slack_id == user_input) || (user.real_name == user_input)}

      return @selected
    end 


    def select_channel(user_input) 
      @selected = @channels.find { |channel| (channel.name == user_input) || channel.slack_id == user_input}

      return @selected
    end 


    def show_details 
      tp @selected, [*@selected.details.keys] if @selected
    end 


    def send_message(text) 
      @selected.send_message(text, @selected) if @selected
    end 
  end 
end 