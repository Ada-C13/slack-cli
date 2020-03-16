module Slack
  class Channel > Slack::Conversation
    attr_reader :name, :topic, :member_count
    
  def initialize(channel)
    super(id)
    @name = 
    @topic = 
    @member_count = 
    @type = :CHANNEL
  end

  def self.get_all
    # HTTP get
    # API endpoint https://slack.com/api/conversations.list default "public_channel" 
  end
end