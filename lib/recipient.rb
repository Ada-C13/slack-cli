module SlackApi
  class Recipient
    attr_reader :slack_id, :name
    def initialize(slack_id, name)
      @slack_id = slack_id 
      @name = name
    end

    # Implemented methods
    def send_message(message)
    end

    def self.get(url, params)
    end

    # Abstract
    def details
    end

    def self.list_all
      
    end
  end
end