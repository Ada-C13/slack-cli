require 'awesome_print'
require_relative 'recipient'

class User < Recipient
  attr_reader :username, :status_text, :status_emoji

  def initialize(slack_id, name, username, status_text, status_emoji)
    super(slack_id, name)
    @username = username
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
    "Slack ID: #{@slack_id}\nName: #{@name}\nUsername: #{@username}\nStatus: #{@status_text}\nEmoji: #{@status_emoji}"
  end

  def self.list_all 
    response = User.get("https://slack.com/api/users.list")
    users = response["members"]
    
    return users.map { |user| User.new(user["id"], user["real_name"], 
      user["profile"]["display_name"], user["profile"]["status_text"],
      user["profile"]["status_emoji"]) }
  end
end
