require "httparty"
require "dotenv"

Dotenv.load
# TODO: remove all above?

class Workspace
  attr_reader :users, :channels

  BASE_URL = "https://slack.com/api/"
  USERS_URL = "#{BASE_URL}users.list"
  CHANNELS_URL = "#{BASE_URL}conversations.list"

  SLACK_TOKEN = ENV["SLACK_TOKEN"]

  # POST_URL = "#{BASE_URL}chat.postMessage"

  def initialize
    @users = load_users
    @channels = load_channels
  end

  def list_users
    result = ""
    users.each do |user|
      result += user.get_details
      result += "\n"
    end
    return result.chop.chop
  end

  def list_channels
    result = ""
    channels.each do |channel|
      result += channel.get_details
      result += "\n"
    end
    return result.chop.chop
  end

  private

  def load_users
    query = {
      token: SLACK_TOKEN
    }

    response = HTTParty.get(USERS_URL, query: query)

    users = response["members"].map do |user|
      User.new(
        slack_id: user["id"],
        name: user["name"],
        real_name: user["profile"]["real_name"]
      )
    end
    return users
  end

  def load_channels
    query = { token: SLACK_TOKEN }
    response = HTTParty.get(CHANNELS_URL, query: query)

    channels = response["channels"].map do |channel|
      Channel.new(
        slack_id: channel["id"],
        name: channel["name"],
        topic: channel["topic"]["value"],
        member_count: channel["num_members"]
      )
    end
    return channels
  end
  
end