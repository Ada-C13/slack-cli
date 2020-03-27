require_relative 'recipient.rb'
class Channel < Recipient
  
  def initialize(name, slack_id, topic, member_count)
    super(name, slack_id)
    @details["topic"] = topic
    @details["num_members"] = member_count
  end

  def topic
    return details["topic"]
  end

  def member_count
    return details["num_members"]
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