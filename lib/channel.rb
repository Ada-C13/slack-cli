require_relative "recipient"

class Channel < Recipient
  attr_reader :topic, :num_members

  CHANNEL_URL = "https://slack.com/api/channels.list"

  def initialize(topic:, num_members:, slack_id:, name:)
    super(slack_id: slack_id, name: name)
    @topic = topic
    @num_members = num_members
  end

  def details
    response = self.get(CHANNEL_URL, {token: SLACK_TOKEN})
  end

  def self.list_all
    # Use specific api endpoint
    # error handling? 
    #raise Exception.new(response['error']) unless response["ok"]
    response = self.get(CHANNEL_URL)
    channels = []
    response["channels"].each do |channel| # maybe do map here
      channels << Channel.new(
        topic: channel['topic']['value'],
        num_members: channel['num_members'],
        slack_id: channel['id'],
        name: channel['name']
      )
    end
    return channels
  end
end
