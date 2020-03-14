require_relative 'recipient'

module Slack
  class User < Recipient

    SLACK_TOKEN = {
      token: ENV["SLACK_TOKEN"]
    }
 
    attr_reader :slack_id, :name, :real_name, :status_text, :status_emoji
    
    def initialize(real_name: nil, status_text: nil, status_emoji: nil, **args)
      super(**args)

      @real_name = real_name 
      @status_text = status_text 
      @status_emoji = status_emoji
    end 

    
    def details 
      return {
        :slack_id => @slack_id,
        :name => @name, 
        :real_name => @real_name, 
        :status_text => @status_text, 
        :status_emoji => @status_emoji
      }
    end 

    def self.list_all 
      response_data = self.get(USER_URL)

      users = response_data["members"]

      return users.map do |user| 
        self.new({
          slack_id: user["id"], 
          name: user["name"], 
          real_name: user["real_name"], 
          status_text: user["status_text"], 
          status_emoji: user["status_emoji"]
          })
      end 
    end 
  end 
end 