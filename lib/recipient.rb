require 'dotenv'
require 'httparty'


Dotenv.load

BASE_URL = "https://slack.com/api/chat.postMessage"
KEY = ENV["SLACK_TOKEN"]


class Recipient
  attr_accessor :name, :id
  def initialize(name = nil, id = nil)
    @name = name
    @id = id
  end

  def self.create
    raise NotImplementedError
  end


  def send_message(message,selected_recipient)
    puts "do you see this in send message?"
    puts selected_recipient.id
    response = HTTParty.post(
      "#{BASE_URL}", {
      #headers: {'Content-Type' => 'application/json'},
      body: {
      token: KEY,
      channel: selected_recipient.id,
      text: message
      }
    })
    puts "message sent"
    return response.code == 200 && response.parsed_response["ok"]
  end

  # def self.details(recipient)
  #   if recipient.user_name != nil
  #     workspace = Workspace.new
  #     users = workspace.users
  #     users["members"].each do |member|
  #       if member["name"] == recipient.user_name
  #         puts member["name"]
  #         puts member["real_name"]
  #         puts member["id"]
  #       end
  #     end

  #   elsif @user_id != nil 
  #     workspace = Workspace.new
  #     users = workspace.users
  #     users["members"].each do |member|
  #       if member["id"] == recipient.user_id
  #         puts member["name"]
  #         puts member["real_name"]
  #         puts member["id"]
  #       end
  #     end
  #   elsif @channel_name != nil
  #     workspace = Workspace.new
  #     channels = workspace.channels
  #     channels["channels"].each do |channel|
  #       if channel["name"] == recipient.channel_name
  #         puts channel["topic"]["value"]
  #         puts channel["num_members"]
  #         puts channel["id"]
  #       end
  #     end
  #   elsif @channel_id != nil
  #     workspace = Workspace.new
  #     channels = workspace.channels
  #     puts "do you see me (self.details)?"
  #     channels["channels"].each do |channel|
  #       if channel["id"] == recipient.channel_id
  #         puts channel["topic"]["value"]
  #         puts channel["num_members"]
  #         puts channel["id"]
  #       end
  #     end
  #   end
  # end
end