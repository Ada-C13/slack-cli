require 'httparty'
require 'dotenv'
require 'awesome_print'

require_relative 'recipient'

Dotenv.load

class User < Recipient
  attr_reader :username

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
    base_url = "https://slack.com/api/users.list"
    query = {
      token: ENV["SLACK_TOKEN"]
    }

    response = HTTParty.get(base_url, query: query)
    users = response["members"]
    return users.map { |user| User.new(user["id"], user["real_name"], 
      user["profile"]["display_name"], user["profile"]["status_text"],
      user["profile"]["status_emoji"]) }
  end

end

# user = User.new("12345", "Ekaterina", "Katty", "Happy", "🐯")
# puts user.details