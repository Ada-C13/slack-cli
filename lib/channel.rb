require_relative "recipient"


class Channel < Recipient
  attr_reader :topic, :member_count
  
  def initialize(topic: nil, member_count: nil, slack_id:, name:)
    super(slack_id: slack_id, name: name)
    @topic = topic || {}
    @member_count = member_count || []
  end



end

  