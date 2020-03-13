class Channel < Recipient
  attr_reader :name, :topic, :member_count, :slack_id

  def initialize(name:, slack_id:, topic:, member_count:)
    super(name: name, slack_id: slack_id)
    @topic = topic == "" ? "not set" : topic
    @member_count = member_count
  end

  def get_details
    # topic = "not set" if topic == ""
    return "#{name} => topic: #{topic}, members #: #{member_count}, Slack ID: #{slack_id}"
  end

end