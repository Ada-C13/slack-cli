


module Slack
  class Conversation
    attr_reader :id
    
    def initialize(id)
      @id = id
      @type = nil
    end

    # Super method to send messages to selected conversation.
    def post_message(message)
      # API ENDPOINT: https://slack.com/api/chat.postMessage 
      
    end

    # Placeholder method to be defined in child classes.
    # Method will return a bunch of details about specified conversation 
    def details
      raise NotImplementedError, "Define DETAILS method in child class."
    end


    # CLASS METHODS

    # Method uses http get to retrieve all Conversation "objects"
    def self.get_all 
      raise NotImplementedError, "Define GET_ALL method in child class."
      # could implement here if we want a list of ALL conversation types at some point
    end

    # Method takes the results of get_all and pretty-prints them.
    def self.list_all
      raise NotImplementedError, "Define LIST_ALL method in child class."
      # could implement here if we want a pretty-print of ALL conversation types at some point
      # perhaps a "show all convos our app is involved in" feature 
    end

  end
end