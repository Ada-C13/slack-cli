require_relative 'recipient'

class Member < Recipient
  attr_reader :name, :real_name, :id, :is_bot

  def initialize(name:,real_name:,id:,is_bot:)
    super(name, id)
    @real_name = real_name
    @is_bot = is_bot
  end
  
  # username, real name, and Slack ID
  def self.all
    get_recipients(MEMBER_URL)["members"].map {|member| 
      Member.new(
        name: member["name"], 
        real_name: member["profile"]["real_name"], 
        id: member["id"],
        is_bot: member["is_bot"]
      )
    }
  end
end