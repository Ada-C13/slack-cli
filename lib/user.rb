require 'httparty'
require 'dotenv'
require 'awesome_print'

require_relative 'recipient'

Dotenv.load

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(slack_id, name, username)
    super(slack_id, name)
    @username = username
  end

  def details
  end

  def self.list_all
    base_url = "https://slack.com/api/users.list"
    query = {
      token: ENV["SLACK_TOKEN"]
    }

    response = HTTParty.get(base_url, query: query)
    users = response["members"]
    return users.map { |user| User.new(user["id"], user["name"], 
      user["real_name"]) }
  end

end

