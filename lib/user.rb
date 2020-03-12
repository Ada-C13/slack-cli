require_relative 'recipient'
require 'httparty'
require 'dotenv'



class UserRecipient < Recipient 
  attr_reader :real_name, :status_text, :status_emoji 

  def initialize(slack_id, name, real_name, status_text, status_emoji)
    super(slack_id, name)
    @real_name = real_name 
    @status_text = status_text
    @status_emoji = status_emoji 

  end 

  def details 
    pretty_string = "DETAILS:
    Slack ID: #{@slack_id}
    Name: #{@name}
    Real Name: #{@real_name}
    Status Text: #{@status_text}
    Status Emoji: #{@status_emoji}
    "
    return pretty_string
   
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
    
    self.list_all.each do |user|
      if id == user.slack_id
        return user
      end 
    end
    return "USER NOT FOUND"
  end 

  def send_message(message)
    query = {
      token: ENV["SLACK_TOKEN"],
      text: message,
      channel: @slack_id
    }
    response = HTTParty.post(BASE_URL + "chat.postMessage", query: query)

  end 
end 

