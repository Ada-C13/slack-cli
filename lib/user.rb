require "httparty"
require "dotenv"
require "table_print"
require_relative "recipient"

class User < Recipient
  attr_accessor :real_name, :status_text, :status_emoji

  # every time
  def initialize(slack_id, name, real_name, status_text = nil, status_emoji = nil)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def self.list_users
    # also can use self.
    response = Recipient.get("users.list")

    unless response["ok"] == true
      raise SlackError, "There was an error. The error message is #{response["error"]}"
    end

    user_list = response["members"].map do |user|
      slack_id = user["id"],
                 name = user["name"],
                 real_name = user["profile"]["real_name"],
                 status_text = user["profile"]["status_text"],
      status_emoji = user["profile"]["status_emoji"]

      User.new(slack_id, name, real_name, status_text, status_emoji)
    end
    return user_list
  end
end #load_all method
