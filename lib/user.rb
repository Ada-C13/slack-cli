require_relative 'recipient'

class User < Recipient
  attr_reader :real_name

  def initialize(slack_id:, name:, real_name:)
    super(slack_id: slack_id, name: name)
    @real_name = real_name
  end

  def details
    tp self, "name", "real_name", "slack_id"
    return self
  end

  def self.list_all
    data = User.get("https://slack.com/api/users.list")
    users = data["members"].map do |member|
      name = member["name"]
      real_name = member["real_name"] ||= name
      slack_id = member["id"]
      User.new(slack_id: slack_id, name: name, real_name: real_name)
    end

    return users
  end
end