require 'httparty'

module SlackApp
  class Recipient
    BASE_URL = "https://slack.com/api/"
    API_KEY = ENV["SLACK_TOKEN"]
    
    attr_reader :slack_id, :name 
    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name 
    end 
    
    def send_message(message)
    end 
    
    def self.get(url, params = {})
      params[:token] = API_KEY     
      HTTParty.get("#{BASE_URL}#{url}", query: params )
    end 
    ###abstract 
    #details 
    #self.list_all

    
    
  end 
end 

#some_user.send_message("contents of the message")

#channel get details but not all at once 