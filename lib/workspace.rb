require "dotenv"
require "httparty"
require_relative "direct_message"
require_relative "channel"
require_relative "user"

module Slack
  class Workspace
    # attr_reader :users, :conversations, :selected
    attr_reader :users, :selected
    
    def initialize
      @users = User.list_all
      #@conversations = Conversation.list_all 
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