require_relative 'recipient'

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji
  def initialize(slack_id, name, real_name, status_text, status_emoji)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
  end

  def self.list_all
    response = HTTParty.get(BASE_URL + "users.list", query: PRAMS)
    users_array = []
    response["members"].each do |member|
      users_array << { 
        nickname: member["name"],
        real_name: member["real_name"],
        id: member["id"]
      }
    end
    return users_array
  end
end