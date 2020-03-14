require_relative "recipient"

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(slack_id, name, real_name, status_text = nil, status_emoji = nil)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  #______ CLASS METHODS _____________

  # Class method to get list of all Users

  def self.list_users
    retrieved_response = self.get_all("users.list")

    if retrieved_response["ok"] != true
      raise SlackAPIError, "An error has occurred: #{retrieved_response["error"]}"
    else
      users_list = retrieved_response["members"].map do |user|
        slack_id = user["id"]
        name = user["name"]
        real_name = user["profile"]["real_name"]
        status_text = user["profile"]["status_text"]
        status_emoji = user["profile"]["status_emoji"]

        User.new(slack_id, name, real_name, status_text, status_emoji)
      end
    end

    return users_list
  end

  def details
    # IMPLEMENT SHOW DETAILS IN USER CLASS
  end
end
