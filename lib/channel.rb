require_relative 'recipient'

class Channel < Recipient
  attr_reader :name, :topic, :member_count, :id

  CHANNEL_URL = 'https://slack.com/api/channels.list'
  MEMBER_URL = 'https://slack.com/api/users.list'
  TOKEN = ENV['SLACK_TOKEN']

  def initialize(name:,topic:,member_count:,id:)
    super(name, id)
    @topic = topic
    @member_count = member_count
  end

  # username, real name, and Slack ID
  def self.all
    query_parameters = {
      token: TOKEN
    }

    response = HTTParty.get(CHANNEL_URL, query: query_parameters)["channels"]
  
    response.map {|channel| 
      Channel.new(
        name: channel["name"],
        topic: channel["topic"]["value"],
        member_count: channel["members"].length,
        id: channel["id"]
      )
    }
  end

end