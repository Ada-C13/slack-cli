require_relative "recipient"

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  USER_URL = 	"https://slack.com/api/users.list"

  def initialize(real_name:, status_text:, status_emoji:, slack_id:, name:)
    super(slack_id: slack_id, name: name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
    #response = self.get(USER_URL, {token: SLACK_TOKEN})
    tp self, "slack_id", "name", "real_name"
  end
  
  def self.list_all
    response = User.get(USER_URL)
    users = []
    response['members'].each do |user|
      users << self.new(
        real_name: user['profile']['real_name'],
        status_text: user['profile']['status_text'],
        status_emoji: user['profile']['status_emoji'],
        slack_id: user['id'],
        name: user['name']
      )
    end
    return users
  end
end
