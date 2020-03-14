module Slack
  class Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id:, name:)
        @slack_id = slack_id
        @name = name
    end

    def self.get(url)
        # token is provided here so I don't need to pass it in children.
        # called in children's self.list
        response = HTTParty.get(url, query: {token: ENV['SLACK_TOKEN']})
        #check for errors
        if (response.code != 200) || (response["ok"] == false)
            raise SlackAPIError, "Error: #{response["error"]}"
        end
        return response
    end

    def self.list
        # How do I test this?
        raise NotImplementedError, "Define this method in a child class"
    end

    # def details
    #     raise NotImplementedError, "Define this method in a child class"
    # end

    # def send_message(text)
    #     #using HTTParty
    #     #check for errors
    # end
  end
end

# Per Devin's live code lecture: here to be accessible to other classes
class SlackAPIError < Exception
end