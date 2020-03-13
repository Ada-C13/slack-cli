class Channel < Recipient
  attr_reader :name, :topic, :member_count, :slack_id

  def initialize(name:, slack_id:, topic:, member_count:)
    super(name: name, slack_id: slack_id)
    @topic = topic == "" ? "not set" : topic
    @member_count = member_count
  end

  def get_details
    return "#{name} => topic: #{topic}, members #: #{member_count}, Slack ID: #{slack_id}"
  end

  ###############
  # CLASS METHODS
  def self.load_all
    response = Channel.get_api_data(url: CHANNELS_URL)
    channels = response["channels"].map do |channel|
      Channel.new(
        slack_id: channel["id"],
        name: channel["name"],
        topic: channel["topic"]["value"],
        member_count: channel["num_members"]
      )
    end
  end
end