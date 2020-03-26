require_relative "recipient"

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(name:, slack_id:, real_name:, status_text:, status_emoji:)
    super(name: name, slack_id: slack_id)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def self.list_all
    data = User.get("https://slack.com/api/users.list")
    users = data["members"].map do |user|
      self.new(
        name: user["name"],
        slack_id: user["id"],
        real_name: user["real_name"],
        status_text: user["profile"]["status_text"],
        status_emoji: user["profile"]["status_emoji"],
      )
    end
    return users
  end

  def details
    tp self, "name", "real_name", "status_text", "status_emoji", "slack_id"
  end
end
