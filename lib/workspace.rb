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
      @users = User.list_all
      @channels = Channel.list_all
      @selected = nil
    end


    def select_channel(input)
      @channels.each do |channel|
        if input == channel.name || input == channel.slack_id
          @selected = channel 
          puts "You selected #{input}"
        end
      end
      if @selected == nil 
        puts "*** Channel name or ID not found. ***"
      end
    end

    def select_user(input)
      @users.each do |user|
        if input == user.name || input == user.slack_id
          @selected = user 
          puts "You selected #{input}"
        end 
      end
      if @selected == nil
        puts "*** User name or ID not found. ***"
      end   
    end

    def show_details(selection)
      if @selected == nil 
        puts "Please select a user or channel before requesting details."
      else
        tp @selected
      end
    end

    # def send_message 
    # end

  end
end