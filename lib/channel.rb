require 'httparty'
require 'recipient'

module SlackApp
  class Channel < Recipient
    
    URL = "channels.list"
    
    attr_reader :topic, :member_count
    def initialize(slack_id, name, topic, member_count)
      super(slack_id, name)
      @topic = topic 
      @member_count = topic 
      @channels = []
      
    end 
    
    def details
       
    end 
    
    def self.list_all
      SlackApp::Recipient.get(URL)
    end 
    
  end 
end 


#channel has users 
#channel does not send the message 
#each channel should be an instance of channel? 