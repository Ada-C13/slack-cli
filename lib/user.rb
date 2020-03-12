require_relative 'recipient'

class User < Recipient
  attr_reader :real_name

  def initialize(slack_id:, name:, real_name:)
    super(slack_id: slack_id, name: name)
    @real_name = real_name
  end

  def self.list_all
    url = "https://slack.com/api/users.list"
    response = Recipient.get(url)
    users = response["members"].map do |member|
      name = member["name"]
      real_name = member["real_name"] ||= name
      slack_id = member["id"]
      User.new(slack_id: slack_id, name: name, real_name: real_name)
    end

    return users
  end

  def details
    puts "User name: #{name}, Real name: #{real_name}, Slack ID: #{slack_id}"
  end
end