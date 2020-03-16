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

  def self.get_list(recipient_type)
    # whyyyyy doesn't super.get_list(recipient_type) work??
    # whhhyyyyy can't I implement a parameter-less version of get_list when i include a get_list matching 
    # parent's method signature???
    # whyyyyyyy
    response = Recipient.get_list(recipient_type)
    list = []
    response.parsed_response["channels"].each do |channel|
      list << Channel.new(channel["name"], channel["id"], channel["topic"]["value"], channel["num_members"]) 
    end
    return list
  end
end