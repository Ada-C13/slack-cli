require "httparty"
require "dotenv"
require 'json'

Dotenv.load


class Channel < Recipient

  attr_reader :topic, :memeber_count
  
  def initialize(topic:, memeber_count:, name:, slack_id:)
    @topic = topic
    @memeber_count = memeber_count
  end

=begin
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
=end 
  end

end