require 'httparty'
require 'dotenv'
Dotenv.load

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end

  def self.get(url)
    params = {
      token: ENV["SLACK_TOKEN"]
    }
    HTTParty.get(url, query: params)
  end
end
