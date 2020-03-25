require "dotenv"
require "httparty"
require_relative "direct_message"
require_relative "channel"
require_relative "user"
require_relative "bad_response_error"

module Slack
  class Workspace
    # attr_reader :users, :conversations, :selected
    attr_reader :users, :channels, :selected
    
    
    
    def initialize
      @users = User.list_all
      @channels = Channel.list_all
      @direct_messages = DirectMessage.list_all
      @selected = nil
    end

    # Method selects a user or channel using the name or slack ID. 
    def select_by_id(type, id)
      result = nil

      case type 
        when "channel"
          result = @channels.index { |channel| channel.id == id }
          raise ArgumentError, "no channel with id: #{id}" if result.nil?
          @selected = @channels[result]
        when "user"
          result = @users.index { |user| user.id == id }
          raise ArgumentError, "no user with id: #{id}" if result.nil?
          @selected = @users[result]
      end
    end

    def select_by_index(type, index)
      case type 
      when "channel"
        @selected = @channels[index]
      when "user"
        @selected = @users[index]
      end
    end

    # Method shows details of the currently selected conversation.
    def show_details
      raise InvalidRecipientError, "No selection made yet. User must have a selected conversation."
    end

    # Method posts a message to the currently selected conversation.
    def post_message
      raise InvalidRecipientError, "No target conversation specified. Cannot send message."
    end

    private 

    def find_id
      return

      # check users and conversations for valid target
    end

  end

  class InvalidRecipientError < StandardError
    def initialize(msg="No valid user or conversation.")
      super
    end
  end
end