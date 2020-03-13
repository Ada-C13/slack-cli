require_relative 'recipient'

class Channel < Recipient
  attr_reader :topic, :member_count
  
  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name) 
    @topic = topic 
    @member_count = member_count
  end

  # Created in collaboration with Becca Roach, Shonda Warren, and Ari Bray!  Thanks for your brain power, y'all!
  def self.list_channels
    # response received from get_everthing method in Recipient
    response = Recipient.get_everything("channels.list")
    
    all_channels_list = []

    # you could refactor to use .map
    response["channels"].each do |channel|
      slack_id = channel["id"]
      name = channel["name"]
      topic = channel["topic"]["value"]
      member_count = channel["members"].length
      
      all_channels_list << Channel.new(slack_id, name, topic, member_count)
    end
    
    return all_channels_list
  end
  

  def details
    return "#{super} Topic: #{topic}, Member Count: #{member_count}"
  end
   
end