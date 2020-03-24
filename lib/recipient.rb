require "httparty"

class Recipient 

  attr_reader :slack_id, :name

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end

  # ----- IMPLEMENTED METHODS -----

  # gets desired data from Slack API 
  def self.get(url)
    requested_data = HTTParty.get(url, query: {token: ENV["BOT_TOKEN"]})

    if requested_data.code != 200 || requested_data["ok"] == false
      raise SlackAPIError, "Encountered error: #{requested_data["error"]}"
    end 

    return requested_data
  end

  # post a message to a slack channel 
  def send_message(message)
    message_reciever = self.slack_id

    sent_message_details = HTTParty.post("https://slack.com/api/chat.postMessage", 
                                          query: {token: ENV["BOT_TOKEN"], channel: message_reciever, text: message} )

    if sent_message_details["ok"] == false
      raise SlackAPIError, "Encountered error: #{sent_message_details["error"]}"
    else 
      puts "\n"
      puts "Message sent sucessfully."
    end

    return sent_message_details
  end

  # ----- ABSTRACT METHODS -----

  def self.list_all
    raise NotImplementedError, "Implement me in a child class!"
  end

  def details
    raise NotImplementedError, "Implement me in a child class!"
  end

end

# custom exception created here so that it is accessible by all other classes in this project
class SlackAPIError < Exception
end