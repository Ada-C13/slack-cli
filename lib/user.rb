require "httparty"
require "awesome_print"
require_relative "recipient"


USER_LIST_URL = "https://slack.com/api/users.list"

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

    user_lists = []
    response["members"].each do |member|
      user_lists << User.new(
        slack_id = member["id"],
        name = member["name"],
        real_name = member["real_name"],
        status_text = member["profile"]["status_text"], 
        status_emoji = member["profile"]["status_emoji"]
      )
    end
    return user_lists
  end
end