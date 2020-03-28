require_relative 'recipient'

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(real_name:, status_text:, status_emoji:, name:, slack_id:)
    super(slack_id: slack_id, name: name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
    return details = "Slack ID: #{self.slack_id}, Name: #{self.name}, Real Name: #{self.real_name}, Status Text: #{self.status_text}, Status Emoji: #{self.status_emoji}" 
end

  def self.list_all
    #get the data
    data = self.get("https://slack.com/api/users.list")
    users = []
    data["members"].each do |user|
      users << User.new(
              name: user["name"],
              slack_id: user["id"],
              real_name: user["profile"]["real_name"],
              status_emoji: user["profile"]["status_emoji"],
              status_text: user["profile"][["status_text"]]
      )
    end

    return users
  end
end