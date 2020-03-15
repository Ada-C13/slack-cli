require_relative 'recipient'

module Slack
  
  class User < Recipient
 
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
      response_data = self.get(USER_URL, SLACK_TOKEN)

      users = response_data["members"]

      # Reference: https://rubyinrails.com/2014/04/20/ruby-read-json-file-to-hash/
      file = File.read("bot-settings.json")

      parsed_data = JSON.parse(file)


      return users.map do |user| 

        # Reflect the setting change
        if user["id"] == "USLACKBOT"
          name = parsed_data["name"]
          status_emoji = parsed_data["status_emoji"]
        else 
          name = user["name"] 
          status_emoji = user["status_emoji"]
        end 

        self.new({
          slack_id: user["id"], 
          name: name, 
          real_name: user["real_name"], 
          status_text: user["status_text"], 
          status_emoji: status_emoji
          })
      end 
    end 
  end 
end 