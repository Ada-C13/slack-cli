require_relative "recipient"

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def details
    return tp self, :slack_id, :name, :topic, :member_count
  end

  def self.list_all
    response = Channel.get("conversations.list")
    all = []

    response["channels"].each do |channel|
      all << Channel.new(
        channel["name"],
        channel["id"],
        channel["topic"]["value"],
        channel["num_members"]
      )
    end
    
    return all
  end

end