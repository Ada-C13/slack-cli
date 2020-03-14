require_relative "recipient"

class Channel < Recipient
  attr_reader :topic, :member_count
  def initialize(topic:, member_count:, slack_id:, name:)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end
  def details
    
  end
  def self.list_all
    # Use specific api endpoint
    # error handling? 
    
  end
end