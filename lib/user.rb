require "httparty"
require "awesome_print"
require_relative "recipient"


USER_LIST_URL = "https://slack.com/api/users.list"
POST_URL = "https://slack.com/api/chat.postMessage"

class User < Recipient

  attr_reader :real_name, :status_text, :status_emoji

  def initialize(slack_id, name, real_name, status_text, status_emoji)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def self.list_all
    response = self.get(USER_LIST_URL)

    user_lists = response["members"].map do |member|
      User.new(
        member["id"], 
        member["name"], 
        member["real_name"], 
        member["stataus_text"], 
        member["status_emoji"]
      )
    end
    return user_lists
  end

  def details
    return "Slack ID: #{@slack_id}\nName: #{@name}\nReal Name: #{@real_name}\nStatus Text: #{@status_text}\nStatus Emoji: #{@status_emoji}"
  end
end