require_relative 'recipient'

module Slack
  
  class User < Recipient
 
    attr_reader :slack_id, :name, :real_name, :status_text, :status_emoji
    
    def initialize(real_name: nil, status_text: nil, status_emoji: nil, conversation_id: nil, **args)
      super(**args)

      @real_name = real_name 
      @status_text = status_text 
      @status_emoji = status_emoji
      @conversation_id = conversation_id
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


    def find_conversation_id_for_im
      list = User.load_conversation_ids_for_im 
      
      list.each do |info|
        if info[:slack_id] == @slack_id
          @conversation_id = info[:converstaion_id]
          break
        end  
      end 
      return @conversation_id
    end 


    def load_message_history
      params = {
        token: ENV["SLACK_TOKEN"],
        channel: find_conversation_id_for_im, # Conversation ID 
        limit: 10
      }

      response = HTTParty.get(HISTORY_URL, {
        query: params
      })

      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackApiError, "We failed to get information from API"
      end 

      response_data = JSON.parse(response.body)
      return response_data["messages"]
    end  


    # optional
    def message_history

      workspace = Slack::Workspace.new
      messages = self.load_message_history

      list = []

      messages.each do |message|
        
        if message["subtype"] != "bot_add" && message["subtype"] != "channel_purpose" && message["subtype"] != "channel_join"

          (message["username"]) ? name = message["username"] : name = workspace.find_user_by_id(message["user"]).name

          list << [name, message["text"], Time.at(message["ts"].to_f)]
        end    
      end 
      
      return list
    end 


    def self.list_all 
      response_data = self.get(USER_URL, SLACK_TOKEN)

      users = response_data["members"]

      # Reference: https://rubyinrails.com/2014/04/20/ruby-read-json-file-to-hash/
      file = File.read("bot-settings.json")

      parsed_data = JSON.parse(file)


      return users.map do |user| 

        # Reflect the setting change (optional)
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


    # optional
    # "im" stands for direct message
    def self.load_conversation_ids_for_im 
      params = {
        token: ENV["SLACK_TOKEN"],
        types: "im"
      }

      response_data = self.get(CHANNEL_URL, params)
    
      channels = response_data["channels"]

      return channels.map do |channel|
        {
          :converstaion_id => channel["id"],
          :slack_id => channel["user"]
        }
      end 
    end  

  end 
end 