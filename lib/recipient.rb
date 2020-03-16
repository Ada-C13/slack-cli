#coded along with Devin for Wave 1

require 'httparty'

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end

  def send(message)
    response = HTTParty.post(
      "https://api.slack.com/api/chat.postMessage",
      body:  {
        token: ENV['SLACK_TOKEN'],
        text: message,
        channel: @slack_id
      },
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    )
  end

  def details
    raise NotImplementedError, "Define this method in a child class"
  end
  
  def self.get(url)
    response = HTTParty.get(url, query: {token: ENV['SLACK_TOKEN']})

    if response.code != 200 || response["ok"] == false
      raise SlackAPIError, "We encountered a problem: #{response["error"]}"
    end
  
    return response
  end

  def self.list_all
    raise NotImplementedError, "Define this method in a child class"
  end

end


class SlackAPIError < Exception
end
