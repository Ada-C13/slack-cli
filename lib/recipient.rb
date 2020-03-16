require 'httparty'

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end

  #api endpoint https://api.slack.com/methods/chat.postMessage
  def send_message(msg_text)
    #send the message using HTTParty
    data = HTTParty.get(url, query: {token: ENV['SLACK_TOKEN']})
    #deal with errors, if any
    if data.code != 200
      raise SlackAPIError
    end

    return data
  end

  def details
    raise NotImplementedError, "Define this method in a child class"
  end

  # ------ Class Methods ------

  #this looks like it should be fetcher, based on the API's docs
  def self.get(url)
    #send message using HTTParty

    #check for errors, if any
  end


  #this smells like a bigger factory method
  def self.list_all
    raise NotImplementedError, "Define this method in a child class"
  end

end


class SlackAPIError < Exception
end
