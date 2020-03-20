require_relative "user"
require_relative "channel"
require "pry"

class Workspace
  attr_reader :users, :channels, :query

  Dotenv.load

  BOT_TOKEN = ENV["BOT_TOKEN"]

  def initialize()
    @query = { token: SLACK_TOKEN }
    @users = self.list_all_user
    @channels = self.list_all_channel
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
    response = HTTParty.get(BASE_URL, query: query)["channels"]
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
end
