require "httparty"
require "dotenv"

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def details
    raise NotImplementedError, "Implement me in child class."
  end

  def send_message(text_to_send)
    response = HTTParty.post(
      "https://slack.com/api/chat.postMessage",
      body:  {
        token: SLACK_TOKEN,
        text: text_to_send,
        channel: @slack_id
      },
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    )

    if response.code == 200 && response.parsed_response["ok"]
      return true
    else
      raise SlackAPIError
    end
  end

  private

  # class method to build a url to send to HTTParty invoked in workspace initialize
  def self.get_all(sub_url)
    url = "https://slack.com/api/#{sub_url}?token=#{SLACK_TOKEN}"
    response = HTTParty.get(url)

    if response.code != 200 || response["ok"] == false
      raise SlackAPIError, "We encountered a problem: #{response["error"]}"
    end

    return response
  end
end

# Create custom error class here for use in Recipient child classes
class SlackAPIError < Exception
end