require_relative 'recipient'
require 'httparty'
require 'dotenv'

class UserRecipient < Recipient 
  attr_reader :real_name, :status_text, :status_emoji 

  def initialize(slack_id, name, real_name, status_text, status_emoji)
    super(slack_id, name)
    @real_name = real_name #user["profile"]["real_name"]
    @status_text = status_text #user["profile"]["status_text"]
    @status_emoji = status_emoji #user["profile"]["status_emoji"]

  end 

  def details 
  
   

  end 

  def self.list_all 
    query = {
      token:  ENV["SLACK_TOKEN"]
    }
    response = HTTParty.get(BASE_URL + "users.list", query: query)

    users = response["members"]
    name_array = []
    users.each do |user| 
      name_array << UserRecipient.new(user["id"], user["name"],user["profile"]["real_name"], user["profile"]["status_text"], user["profile"]["status_emoji"])
    end 
    return name_array
  end 

  def self.find(id)
    users = self.list_all
    users.each do |user|
      if id = user["id"]
        return user
      end 
    end
    return ArgumentError.new("Channel not found")
  end 




end 