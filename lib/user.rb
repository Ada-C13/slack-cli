require_relative "recipient"
require "gemoji-parser"

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(slack_id, name, real_name, status_text = nil, status_emoji = nil)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
    puts "The user '#{@name}' has a slack id of #{@slack_id}. Their real name is #{@real_name}."

    if @status_text != nil && @status_text != ""
      puts "Their current status is: #{@status_text}"
    end

    if @status_emoji != nil && @status_emoji != ""
      puts "Their current emoji is: #{EmojiParser.detokenize(@status_emoji)}"
    end
  end

  # Class Methods ---------

  def self.list_users
    retrieved_response = self.get_all("users.list")
    users_list = retrieved_response["members"].map do |user|
      slack_id = user["id"]
      name = user["name"]
      real_name = user["profile"]["real_name"]
      status_text = user["profile"]["status_text"]
      status_emoji = EmojiParser.detokenize(user["profile"]["status_emoji"])

      User.new(slack_id, name, real_name, status_text, status_emoji)
    end

    return users_list
  end
end