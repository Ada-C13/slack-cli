require_relative 'recipient'

class Channel < Recipient
  attr_reader :member_count, :topic

  def initialize(slack_id:,name:,member_count:,topic:)
    super(slack_id,name)
    @member_count = member_count
    @topic = topic 
  end

  def self.get(url,params)
    data = HTTParty.get(url,query: params)["channels"]
    empty_array = []
    data.each do |channel|
      empty_array << new(slack_id: channel["id"], name: channel["name"], member_count:channel["num_members"], topic:channel["topic"]["value"])
    end 
    return empty_array 
  end 
 
end