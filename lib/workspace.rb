require "dotenv"
require "httparty"
require_relative "direct_message"
require_relative "channel"
require_relative "user"

Dotenv.load

SLACK_TOKEN = ENV["SLACK_TOKEN"]


module Slack
  class Workspace
    attr_reader :users, :channels, :selected
    
    def initialize
      @users = User.get_all
      @channels = Channel.get_all # TO-DO: replace this variable with CONVERSATIONS and create methods to list by type of conversation
      @selected = nil
    end

    # Method selects a user or channel using the name or slack ID. 
    def select_by_id(id, type)
    end

    # Method shows details of the currently selected conversation.
    def show_details
      raise InvalidRecipientError, "No selection made yet. User must have a selected conversation."
    end

    # Method posts a message to the currently selected conversation.
    def post_message
      raise InvalidRecipientError, "No target conversation specified. Cannot send message."
    end

  end

  class InvalidRecipientError < StandardError
    def initialize(msg="No valid user or conversation.")
      super
    end
  end
end