require 'httparty'
require 'dotenv'
Dotenv.load

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)
  end

  def self.get(url)
    
    slack_token = ENV["SLACK_TOKEN"]
    params = {token: slack_token}
    response = HTTParty.get(url, query: params)
    
    raise SlackApiError.new("Invalid response from API") if response.code != 200 || response["ok"] == false

    return response
  end

  def details
    raise NotImplementedError, 'Implement me in a child class!'
  end

  def self.list_all
    raise NotImplementedError, 'Implement me in a child class!'
  end


end
