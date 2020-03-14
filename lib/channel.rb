require_relative "recipient"

module SlackApp
  class Channel < Recipient
    
    
    
    attr_reader :topic, :member_count
    def initialize(slack_id, name, topic, member_count)
      super(slack_id, name)
      @topic = topic 
      @member_count = topic 
    end 

    def details 
    end 

    def self.list_all
      response =  SlackApp::Channel.get("https://slack.com/api/conversations.list")
      channels = []
      response["channels"].each do |channel|
        channels << SlackApp::Channel.new(channel["id"], channel["name"], channel["topic"]["value"], channel["num_members"])
      end 
      return channels 
    end 
  end 
end 


#channel has users 
#channel does not send the message 
#each channel should be an instance of channel? 