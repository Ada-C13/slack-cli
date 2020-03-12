require_relative 'recipient'

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji
  
  def initialize(slack_id, name, real_name, status_text = nil, status_emoji = nil)
    super(slack_id, name) 
    @real_name = real_name 
    @status_text = status_text
    @status_emoji = status_emoji
  end
  
  # def details

  # end


  def self.list_users
    # response received from Recipient
    response = Recipient.get_everything("users.list")
    # if response["ok"] != true
    # raise ERROR

    all_users_list = []

    response["members"].each do |member|
      slack_id = member["id"]
      name = member["name"]
      real_name = member["real_name"]
      status_text = member["profile"]["status_text"]
      status_emoji = member["profile"]["status_emoji"]
      
      all_users_list << User.new(slack_id, name, real_name, status_text, status_emoji)
    end
    
    return all_users_list
  end

end