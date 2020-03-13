require_relative 'recipient'

module Slack
  class User < Recipient

    USER_URL = "https://slack.com/api/users.list"

    SLACK_TOKEN = {
      token: ENV["SLACK_TOKEN"]
    }
 
    attr_reader :slack_id, :name, :real_name, :status_text, :status_emoji
    
    def initialize(real_name:, status_text:, status_emoji:, **args)
      super(**args)

      @real_name = real_name 
      @status_text = status_text 
      @status_emoji = status_emoji
    end 
    
    def details 
      return [@slack_id, @name, @real_name, @status_text, @status_emoji]
    end 

    def self.list_all 
      response_data = self.get(USER_URL, SLACK_TOKEN)

      users = response_data["members"]

      return users.map do |user| 
        slack_id = user["id"]
        name = user["name"]
        real_name = user["real_name"]
        status_text = user["status_text"]
        status_emoji = user["status_emoji"]

        self.new(slack_id: slack_id, name: name, real_name: real_name, status_text: status_text, status_emoji: status_emoji)
      end 
    end 
  end 
end 