require "dotenv"
require "httparty"
require_relative "conversation"
require_relative "user"

Dotenv.load

SLACK_TOKEN = ENV["SLACK_TOKEN"]


module Slack
  class Workspace
    attr_reader :users, :channels, :selected
    
    def initialize
      @users = User.get_all
      @channels = Channels.get_all # TO-DO: replace this variable with CONVERSATIONS and create methods to list by type of conversation
      @selected = nil
    end

    # Method selects a user or channel using the name or slack ID. 
    def select_conversation
    end

    # Method shows details of the currently selected conversation.
    def show_details
      raise NoRecipientError, "Cannot display details."
    end

    # Method posts a message to the currently selected conversation.
    def post_message
      raise NoRecipientError, "Cannot send message."
    end

  end

  class NoRecipientError < StandardError
    def initialize(msg="No currently selected user or conversation.")
      super
    end
  end
end