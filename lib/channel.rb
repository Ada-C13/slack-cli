
require_relative 'recipient'

class Channel < Recipient

  attr_reader :topic, :member_count

  def initialize (slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end


 # what do we need to initialize a channel?
 # where do we instantiate a Channel? - IN THE WORKSPACE is where we make the method call to instantiate channels
 
 def self.list_channels
  response = Recipient.get_all("channels.list")

  channel_list = []
  if response["ok"] != true
    raise SlackAPI::SlackError, "There was an error. The error message is #{response["error"]}"
  else
    response["channels"].each do |channel|
      @slack_id = channel["id"]
      @name = channel["name"]
      @topic = channel["topic"]["value"]
      @member_count = channel["num_members"]

      channel_list << Channel.new(@slack_id, @name, @topic, @member_count)
    end
  end

  return channel_list
end



end