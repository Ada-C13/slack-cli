#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'awesome_print'

#require_relative 'slack.rb'

Dotenv.load

module SlackCLI
  class Workspace
    CHANNEL_URL = "https://slack.com/api/conversations.list"
    USER_URL = "https://slack.com/api/users.list"
    
    attr_reader :users, :channels, :selected

    def initialize
      @users = [],
      @channels = []
      @selected = []
    end

    def list_users
      SlackCLI::User.load_all
    end

    def list_channels
      SlackCLI::Channel.load_all
    end

    def select_channel(identifier)
      i = 0
      list_channels = SlackCLI::Channel.load_all
      list_channels.length.times do
        if list_channels[i].name == identifier
          @selected = list_channels[i]
        elsif list_channels[i].name != identifier
          i+=1
        end
      end
      return @selected
    end

    def select_user(identifier)
      i = 0
      list_users = SlackCLI::User.load_all
      list_users.length.times do
        if list_users[i].name == identifier
          @selected = list_users[i]
        elsif list_users[i].name != identifier
          i+=1
        end
      end
      return @selected

    end

    def show_details
      return @selected
    end

    def send_message
    
    end

  end
end