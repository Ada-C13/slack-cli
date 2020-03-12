require_relative 'recipient'

class Channel < Recipient
  attr_reader :name, :topic, :member_count, :id

  def initialize(name:,topic:,member_count:,id:)
    super(name, id)
    @topic = topic
    @member_count = member_count
  end
  
  def self.all
    get_recipients(CHANNEL_URL,"channels").map {|channel| 
      Channel.new(
        name: channel["name"],
        topic: channel["topic"]["value"],
        member_count: channel["members"].length,
        id: channel["id"]
      )
    }
  end
end