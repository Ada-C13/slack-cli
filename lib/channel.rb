require_relative 'recipient'

# add private attributes or methods if needed

class Channel < Recipient
  attr_reader :topic, :member_count
  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def details
  end

  def self.list_all
    response = HTTParty.get(BASE_URL + "conversations.list", query: PRAMS)
    chanels_array = []
    response["channels"].each do |channel|
      chanels_array << {
        nickname: channel["name"],
        topic: channel["topic"]["value"],
        member_count: channel["num_members"],
        id: channel["id"]
      }
    end
  end
end