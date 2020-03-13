require 'httparty'

module SlackApp
  class User < Recipient

    attr_reader :real_name, :status_text, :status_emoji
    def initialize(slack_id, name, real_name, status_text = nil, status_emoji = nil )
      super(slack_id, name)
      @real_name
      @status_text
      
    end
    
    def details
      
    end 
    
   
  end 
end 


#