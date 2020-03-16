require 'dotenv'
require 'httparty'


Dotenv.load

BASE_URL = "https://slack.com/api/chat.postMessage"
# KEY = ENV["SLACK_TOKEN"]


class Recipient
  attr_accessor :name, :id
  def initialize(id, name)
    @name = name
    @id = id
  end

  def self.create
    raise NotImplementedError
  end

  def details
    raise NotImplementedError
  end

  def send_message(message,selected_recipient)
    response = HTTParty.post(
      "#{BASE_URL}", {
      body: {
      token: KEY,
      channel: selected_recipient.id,
      text: message
      }
    })
    puts "message sent"
    return response.code == 200 && response.parsed_response["ok"]
  end
end