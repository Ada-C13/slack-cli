require_relative 'recipient'

class Member < Recipient
  attr_reader :name, :real_name, :id

  CHANNEL_URL = 'https://slack.com/api/channels.list'
  MEMBER_URL = 'https://slack.com/api/users.list'
  TOKEN = ENV['SLACK_TOKEN']

  def initialize(name:,real_name:,id:)
    super(name, id)
    @real_name = real_name
  end
  
  # username, real name, and Slack ID
  def self.all
    query_parameters = {
      token: TOKEN
    }

    response = HTTParty.get(MEMBER_URL, query: query_parameters)["members"]
  
    response.map {|member| 
      Member.new(
        name: member["name"], 
        real_name: member["profile"]["real_name"], 
        id: member["id"]
      )
    }
  end
end