require "httparty"
require "awesome_print"
require_relative "recipient"


USER_LIST_URL = "https://slack.com/api/users.list"

class User < Recipient

  attr_reader :real_name

  def initialize(slack_id, name, real_name)
    super(slack_id, name)
    @real_name = real_name
  end

  def self.list_all
    response = self.get(USER_LIST_URL)

    user_lists = []
    response["members"].each do |member|
      user_lists << User.new(
        slack_id = member["id"],
        name = member["name"],
        real_name = member["real_name"]
      )
    end
    return user_lists
  end
end