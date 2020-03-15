require_relative "user"
require_relative "channel"
require "table_print"
require "terminal-table"
require "json"

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
      @selected = @channels.find { |channel| (channel.name == user_input) || (channel.slack_id == user_input) }

      return @selected
    end 


    def show_details 
      tp @selected, [*@selected.details.keys] if @selected
    end 


    def send_message(text) 
      @selected.send_message(text, @selected) if @selected
    end 


    # Reference: http://blog.pingzhang.io/ruby/2016/07/25/ruby-json-operations/
    def change_setting(username, emoji)
      setting = {
        :name => username,
        :status_emoji => emoji
      }

      File.open("bot-settings.json", "w") do |f|
        f.write(setting.to_json)
      end  
    end 


    def message_history 
      return nil if !@selected 
      return "User selected" if @selected.class == Slack::User

      if @selected 
        rows = @selected.message_history

        table = Terminal::Table.new :headings => ['username', 'text'], :rows => rows
      end 
      
      return table
    end 

    
    def find_user_by_id(slack_id)
      user = @users.find do |user|
        user.slack_id == slack_id 
      end 

      return user
    end 

  end 
end 