require "httparty"
require "dotenv"
require_relative "recipient"
require "table_print"

class User < Recipient
  attr_accessor :real_name, :status_text, :status_emoji

  # every time
  def initialize(slack_id, name, real_name, status_text = nil, status_emoji = nul)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def self.list_users
    response = Recipient.get("users.list")
    user_list = []
    if response["ok"] != true
      raise SlackAPI::SlackError, "There was an error. The error message is #{response["error"]}"
    else
    response["members"].each do |user|
      @slack_id = user["id"]
      @name = user["name"]
      @real_name = user["real_name"]
      @status_text = user["profile"]
      @status_emoji = user["profile"]

      user_list << User.new(@slack_id, @name, @real_name, @status_text,
                            @status_emoji)
      end
    end
    return user_list
  end
end #load_all method
