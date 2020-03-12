require "httparty"
require "dotenv"
require "awesome_print"
require_relative "recipient"

Dotenv.load

class User < Recipient

  USER_LIST_URL = "https://slack.com/api/users.list"
  KEY = ENV["SLACK_TOKEN"]

  def initialize(id, name)
    super(id, name)
  end

  def self.list_all
    query_parameters = {
      token: KEY
    } 

    response = self.get(USER_LIST_URL, query_parameters)

    user_lists = []
    response["members"].each do |member|
      member_info = {
        username: member["name"],
        real_name: member["real_name"],
        slack_id: member["id"]
      }
      user_lists << member_info
    end
    return user_lists
  end

end
