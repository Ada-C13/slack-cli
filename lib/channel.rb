class Channel < Recipient
  attr_reader :name, :topic, :member_count, :slack_id

  def initialize(name:, slack_id:, topic:, member_count:)
    super(name: name, slack_id: slack_id)
    @topic = topic
    @member_count = member_count
  end

  # def get_details
  #   return "#{name} => real name: #{real_name}, Slack ID: #{slack_id}"
  # end

end