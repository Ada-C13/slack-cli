require "httparty"

class Recipient

  attr_reader :slack_id, :name

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end

  def send_message(msg_text)
    url = "https://slack.com/api/chat.postMessage"
    response = HTTParty.post(url, query: {token: ENV['BOT_TOKEN'], channel: self.slack_id, text: msg_text})

    if response.code != 200 || response["ok"] == false
      raise SlackAPIError, "We encountered a problem: #{response["error"]}"
    else
      return true
    end
  end

  def details
    raise NotImplementedError, "Define this method in a child class"
  end

  # ------ Class Methods ------

  
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