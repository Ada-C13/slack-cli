require "httparty"
require "dotenv"

Dotenv.load
# TODO: remove all above?

class Workspace
  attr_reader :users, :channels

  URL = "https://slack.com/api/users.list"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]

  def initialize
    @users = load_users
    @channels = []
  end

  private

  def load_users
    query = {
      token: SLACK_TOKEN
    }

    response = HTTParty.get(URL, query: query)

    users_list = []
    response["members"].each do |user|
      users_list << user
    end
    return users_list
  end

end