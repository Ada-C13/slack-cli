MESSAGE_URL = "https://slack.com/api/chat.postMessage"

module Slack
  class Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id:, name:)
      @slack_id = slack_id
      @name = name
    end

    def self.get(url)
      response = HTTParty.get(url, query: { token: ENV["SLACK_TOKEN"] })
      #check for errors
      if (response.code != 200) || (response["ok"] == false)
        raise SlackAPIError, "Error: #{response["error"]}"
      end
      return response
    end

    def self.list
      raise NotImplementedError, "Define this method in a child class"
    end

    def details
      raise NotImplementedError, "Define this method in a child class"
    end

    def send_message(text)
      response = HTTParty.post(MESSAGE_URL, body:  {
        token: ENV["SLACK_TOKEN"],
        channel: self.slack_id,
        text: text
      },
      headers: { "Content-Type" => "application/x-www-form-urlencoded" }
    )
      #check for errors
      if response.code != 200 || response["ok"] == false
        raise SlackAPIError, "Error: #{response["error"]}"
      end
    end
  end
end

# Per Devin's live code lecture: here to be accessible to other classes
class SlackAPIError < Exception
end
