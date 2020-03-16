require_relative "recipient"

class User < Recipient
  attr_reader :real_name

  def initialize(name, slack_id, real_name)
    super(name, slack_id)
    @real_name = real_name
  end

  def self.list_all
    response = User.get("https://slack.com/api/users.list")
    user_list = response["members"].map do |member|
      User.new(
        name = member["name"],
        slack_id = member["id"],
        real_name = member["real_name"]
      )
    end

    return user_list
  end

  def details
    return "Slack name: #{name}\nSlack ID: #{slack_id}\nReal name: #{real_name}"
  end
end
