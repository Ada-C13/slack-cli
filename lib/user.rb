require_relative 'recipient'

class User < Recipient
  attr_reader :slack_id, :username, :real_name, :status_text, :status_emoji

  def initialize(slack_id:, username:, real_name:, status_text:, status_emoji:)
    @slack_id = slack_id
    @username = username
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
    tp self, "slack_id", "username", "real_name", "status_text", "status_emoji"
  end

  def self.list_all
    #list all of the channels in this workspace
    url = "https://slack.com/api/users.list"

    response = User.get(url)

    users = response["members"].map do |u|
      User.new(
        slack_id: u["id"],
        username: u["name"],
        real_name: u["real_name"],
        status_text: u["profile"]["status_text"],
        status_emoji: u["profile"]["status_emoji"]
      )
    end
    return users
  end
end