require_relative "recipient"
require 'httparty'
require 'dotenv'

Dotenv.load

BASE_URL = "https://slack.com/api/conversations.list"

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(real_name:, status_text:, status_emoji:, name:, slack_id:)
    super(slack_id: slack_id, name: name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end


  # def details
  # end


  def self.list_all
 
    response = User.get("https://slack.com/api/users.list")
    users = []

    response["members"].each do |item|
      users << User.new(
                name: item["name"],
                slack_id: item["id"],
                real_name: item["real_name"],
                status_text: item["profile"]["status_text"],
                status_emoji: item["profile"]["status_emoji"]
      )
    end
    return users
  end
end

  