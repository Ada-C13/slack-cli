require_relative 'recipient.rb'
class Channel < Recipient
  attr_reader :topic, :member_count
  def initialize(name, slack_id, topic, member_count)
    super(name, slack_id)
    @topic = topic
    @member_count = member_count
  end

  def details
    return super + [topic, member_count]
  end

  def self.make_query
    return super("channel")
  end

  def self.get_list
    response = self.make_query
    list = []
    response.parsed_response["channels"].each do |channel|
      list << Channel.new(channel["name"], channel["id"], channel["topic"]["value"], channel["num_members"]) 
    end
    return list
  end
end