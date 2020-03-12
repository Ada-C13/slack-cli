require_relative 'recipient'

class Channel < Recipient

  # Generator
  attr_reader :id, :name, :topic, :member_count

  # Constructor
  def initialize(id, name, topic, member_count)
    @id    = id
    @name  = name
    @topic = topic
    @member_count = member_count

    super(id, name)
  end

  # Return details for a channel
  def details
    return "ID = #{@id}, name = #{@name}, topic = #{@topic}, member_count = #{@member_count}"
  end

  # Get channels from slack
  def self.list_all

    result = Recipient.get("conversations.list")
    channels = []
    result["channels"].each do |channel|
      id           = channel["id"]
      name         = channel["name"]
      topic        = channel["topic"]["value"]
      member_count = channel["num_members"]
      channels << Channel.new(id, name, topic, member_count)
    end
    return channels

  end

end # Class
