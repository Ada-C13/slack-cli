require 'httparty'

class Recipient
  attr_reader :name, :slack_id

  def initialize(name:, slack_id:)
    @name = name
    @slack_id = slack_id
  end

  
  def send_message(message)
    response = HTTParty.post("https://slack.com/api/chat.postMessage", query: {token: ENV['BOT_TOKEN'], channel: self.slack_id, text: message })

    if response.code != 200 || response["ok"] == false
      raise SlackAPIError, "We encountered a problem: #{response["error"]}"
    end
  end

  def self.get(url)
    response = HTTParty.get(url, query: {token: ENV['SLACK_TOKEN']})

    if response.code != 200 || response["ok"] == false
      raise SlackAPIError, "We encountered a problem: #{response["error"]}"
    end

    return response

  end
  
  def details
    raise NotImplementedError, 'Implement me in a child class!'
  end

  def self.list_all
    raise NotImplementedError, 'Implement me in a child class!'
  end

end

class SlackAPIError < Exception
end