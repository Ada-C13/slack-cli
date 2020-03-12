require_relative 'recipient'

class Member < Recipient
  attr_reader :name, :real_name, :id

  def initialize(name:,real_name:,id:)
    super(name, id)
    @real_name = real_name
  end
  
  # username, real name, and Slack ID
  def self.all
    get_recipients(MEMBER_URL,"members").map {|member| 
      Member.new(
        name: member["name"], 
        real_name: member["profile"]["real_name"], 
        id: member["id"]
      )
    }
  end
end