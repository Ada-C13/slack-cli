require 'HTTParty'
require 'dotenv'
require 'table_print'
require_relative 'workspace'
require_relative 'channel'
require_relative 'slack'
require_relative 'recipient'

Dotenv.load

# Recipient contains:
#self.list_all
#details


class User < Recipient

  attr_reader :name, :slack_id, :real_name, :status_emoji, :status_text

  def initialize(name:, slack_id:, real_name:, status_emoji:, status_text:)
    super(name, slack_id)
    @real_name = real_name
    @status_emoji = status_emoji
    @status_text = status_text

  end 

  def self.list_all 
    data = self.get("https://slack.com/api/users.list")
    users = []
    data["members"].each do |user|
      users << User.new(
                name: user["name"],
                slack_id: user["id"],
                real_name: user["profile"]["real_name"],
                status_emoji: user["profile"]["status_emoji"],
                status_text: user["profile"]["status_text"]
      )

    end
    return users

  end

end
