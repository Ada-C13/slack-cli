require_relative 'recipient'

class User < Recipient
  
  attr_reader :real_name

  def initialize(real_name:, name: , slack_id:)
    super(name: name, slack_id: slack_id)

    @real_name = real_name
  end


  def details
    tp self, "name", "real_name", "slack_id"
  end

  # =====Class methods=====
  def self.list_all

    response = User.get("https://slack.com/api/users.list")

    # parsing the data

    
    users = response["members"].map do |item|
      User.new(
        real_name: item["real_name"],
        name: item["name"],
        slack_id: item["id"],
      )
    end

    return users
  end
end