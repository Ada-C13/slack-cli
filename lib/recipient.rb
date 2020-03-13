require 'HTTParty'
require 'dotenv'

# require_relative 'channel.rb'
# require_relative 'user.rb'

Dotenv.load


class Recipient
  attr_reader :slack_id, :name
  def initialize(slack_id)
    @slack_id = slack_id
    @name = ""
  end

  def send_message(message)
    url = "https://slack.com/api/chat.postMessage"

    response = HTTParty.post(
      url,
      body:  {
        token: ENV['SLACK_TOKEN'],
        text: message,
        channel: @slack_id
      },
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    )

  end

  def self.get(url,params)
    response = HTTParty.get(url,query: params)
    return response
  end

  def details
    #should be implemented in child class
  end

  def self.list_all
    #should be implemented in child class
  end

end