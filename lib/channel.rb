require 'httparty'


module SlackApp
  class Channel < Recipient
    
    
    
    attr_reader :topic, :member_count
    def initialize(slack_id, name, topic, member_count)
      super(slack_id, name)
      @topic = topic 
      @member_count = topic 
    end 
  end 
end 


#channel has users 
#channel does not send the message 
#each channel should be an instance of channel? 