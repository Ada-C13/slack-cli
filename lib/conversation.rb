require_relative "bad_response_error"

module Slack
  class Conversation
    
    def initialize(data)
      @id = data["id"] #template
    end

    # Super method to send messages to selected conversation.
    def post_message(message)
      # API ENDPOINT: https://slack.com/api/chat.postMessage 
      # query: @id
    end

    # Placeholder method to be defined in child classes.
    # Method will return a bunch of details about specified conversation 
    # Should probably implement in child classes so we can control the description to be user-friendly
    # but if we're ok with a generic details printout, we can do it at parent Conversation level too
    def details
      raise NotImplementedError, "Define DETAILS method in child class."
    end


    # CLASS METHODS

    def self.list_all

      # Template, extend this method in child classes.
    end

    private 

    def self.get_all(query)
      data = HTTParty.get("https://slack.com/api/conversations.list?", query: query)
      raise BadResponseError, "Conversations.list endpoint response IS NOT OK." unless data["ok"]
      return data
    end

  end
end