require_relative 'recipient'

class User < Recipient

  def initialize(slack_id, name, real_name, status_text = nil, status_emoji = nil)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end



 # Class method to get list of all Users
  def self.list_users
    retrieved_response = Recipient.get_all("users.list")
  
    users_list = []
    if retrieved_response["ok"] != true
      raise SlackAPI::SlackError, "There was an error. The error message is #{retrieved_response["error"]}"
    else
      retrieved_response["members"].each do |user|
        @slack_id = user["id"]
        @name = user["name"]
        @real_name = user["real_name"]
        @status_text = user["profile"]["status_text"]
        @status_emoji = user["profile"]["status_emoji"]
  
        users_list << User.new(@slack_id, @name, @real_name, @status_text, @status_emoji)
      end
    end
  
    return users_list
  end
  
end