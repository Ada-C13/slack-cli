require 'httparty'
require_relative 'recipient'

module SlackApp
  class User < Recipient

    attr_reader :real_name, :status_text, :status_emoji
    def initialize(slack_id:, name:, real_name:, status_text:, status_emoji: )
      super(slack_id, name)
      @real_name
      @status_text
      
    end
    
    def details
      
    end 

    def self.list_all
      #get the data
      response = self.get("https://slack.com/api/users.list")
  
      #parse the data, instansiate an object
      users = []
  
      response["members"].each do |user|
        users << self.new(
                  name: user["name"],
                  slack_id: user["id"],
                  real_name:  user["real_name"],
                  status_text: user["profile"]["status_text"],
                  status_emoji: user["profile"]["status_emoji"]
        )
        end
          return users
    end
    
   
  end 
end 


#