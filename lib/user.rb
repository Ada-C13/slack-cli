require "httparty"
require "dotenv"
require 'json'
require_relative "recipient"

Dotenv.load

class User < Recipient

  attr_reader :real_name, :status_text, :status_emoji
  
  def initialize(real_name: , status_text: , status_emoji: , name: , slack_id: )
    super(slack_id: slack_id, name: name)
    
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji

  end

  def detail
    tp self, "slack_id", "name", "real_name"
  end

  def self.list_all
    data = User.get("https://slack.com/api/users.list")
    index = 0

   users = []

    data["members"].each do |user|
      users << User.new(
        name: user["name"],
        slack_id: user["id"],
        real_name: user["real_name"],
        status_text: user["profile"]["status_text"],
        status_emoji: user["profile"]["status_emoji"])
    end
    return users

  end

end

