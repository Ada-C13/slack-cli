require_relative "user"
require_relative "channel"
require "pry"

class Workspace
  attr_reader :users, :channels, :selected, :query

  Dotenv.load

  def initialize()
    @query = { token: SLACK_TOKEN }
    @users = self.list_all_user
    @channels = self.list_all_channel
    @selected = nil
  end

  def list_all_user
    all_users = []
    response = HTTParty.get(User::BASE_URL, query: query)["members"]

    response.each do |person|
      all_users << User.new(person["name"], person["id"])
    end
    return all_users
  end

  def list_all_channel
    all_channel = []
    response = HTTParty.get(Channel::BASE_URL, query: query)["channels"]
    response.each do |channel|
      all_channel << Channel.new(
        channel["topic"]["value"],
        channel["members"].length,
        channel["name"],
        channel["id"]
      )
    end
    return all_channel
  end

  def select_user(user_id)
    @users.each do |user|
      if user_id == user.slack_id
        @selected = user
      elsif user_id == user.name
        @selected = user
      end
    end
    return @selected
  end

  def select_channel(channel_id)
    @channels.each do |channel|
      if channel_id == channel.slack_id
        @selected = channel
      elsif channel_id == channel.name
        @selected = channel
      end
    end
    return @selected
  end
end
