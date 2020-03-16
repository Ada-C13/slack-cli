require_relative "recipient"

class User < Recipient
  
  attr :real_name, :status_text, :status_emoji

  def initialize(real_name:, status_text:, status_emoji:, name:, slack_id:)
    super(slack_id: slack_id, name: name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  # displays user info to command line
  def details
  end 

  # ----- CLASS METHODS -----

  # gathers relevant information about users in this workspace
  def self.list_all
    data = self.get("https://slack.com/api/users.list")

    user_info = []

    data["members"].each do |user|
      user_info << User.new(
                        name: user["name"],
                        slack_id: user["id"], 
                        real_name: user["profile"]["real_name"], 
                        status_emoji: user["profile"]["status_emoji"], 
                        status_text: user["profile"]["status_text"]
      )
    end 

    return user_info
  end 
  
end 