require "httparty"

module SlackCLI
  class SlackApiError < Exception; end

  class Recipient
    MESSAGE_URL = "https://slack.com/api/chat.postMessage"
    attr_reader :slack_id, :name

    def initialize(slack_id:, name:)
      @slack_id = slack_id
      @name = name
    end

    def send_message(message, selected)
      response = HTTParty.post(
        MESSAGE_URL,
        headers: {
          "Content-Type" => "application/x-www-form-urlencoded",
        },
        body: {
          token: ENV["SLACK_TOKEN"],
          text: message,
          channel: selected.slack_id,
        },
      )

      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackApiError, "error: #{response.parsed_response["error"]}"
      end

      return true
    end
  end
end
