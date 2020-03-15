#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'awesome_print'
require 'date'

require_relative 'channel.rb'
require_relative 'users.rb'

# Dotenv.load

module SlackCLI
  class Workspace
    BASE_URL = "https://slack.com/api/"
    POST_URL = "https://slack.com/api/chat.postMessage"
    #HISTORY_URL = "	https://slack.com/api/conversations.history"
    SLACK_TOKEN = ENV["OAuth"]
    USER_TOKEN = ENV["User_token"]

    attr_reader :users, :channels, :selected

    def initialize
      @users = SlackCLI::User.load_all
      @channels = SlackCLI::Channel.load_all
      @selected = []
    end
  
    def find_object(object_type, search_term)
      object_type.find {|object| 
        object.slack_id == search_term || object.name == search_term }
    end

    def select_user(identifier)
      @selected = find_object(@users, identifier)
      #p @selected
    end

    def select_channel(identifier)
      @selected = find_object(@channels, identifier)
      #p @selected
    end

    def show_history
      response = HTTParty.get(BASE_URL + "conversations.history", query: {token: USER_TOKEN, channel: @selected.slack_id})
      #p response
      chat_history = []
      # p response.parsed_response["messages"]["text"]
      response.parsed_response["messages"].each do |message|
        text = message["text"]
        sender = message["bot_id"]
        chat_history << [text, sender]
      end
      if chat_history == nil

      else
        return chat_history
      end
    end

    def set_reminder(message, time)
      response = HTTParty.post(BASE_URL + "reminders.add", {
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: {
          token: USER_TOKEN,
          text: message,
          time: time 
        }
      })
    end

    def message_to_outbox(message)
      if @selected.slack_id[0] == "U"
        #p @selected.slack_id
        resp = HTTParty.post(POST_URL, {
            headers: {
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: {
              token: SLACK_TOKEN,
              as_user: true,
              channel: @selected.slack_id,
              text: SlackCLI::User.send_message(message)
            }
          })

        
      resp["ok"] ? "Message delivered!" : "Message unsucessful: #{response["error"]}"
    
      elsif @selected.slack_id[0] == "C"
        resp = HTTParty.post(POST_URL, {
            headers: {
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: {
              token: SLACK_TOKEN,
              channel: @selected.slack_id,
              text: SlackCLI::Channel.send_message(message)
            }
          })

        resp["ok"] ? "Message delivered!" : "Message unsucessful: #{response["error"]}"
      end
    end
  end
end