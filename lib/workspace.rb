
require 'dotenv'
require 'httparty'

require_relative 'recipient'
require_relative 'user'
require_relative 'channel'

# @TODO: Load environment objects and key in an actual method
Dotenv.load

KEY = ENV["SLACK_TOKEN"]

class Workspace
  attr_accessor :channels, :users, :selected_recipient

  def initialize
    @users = Workspace.get("https://slack.com/api/users.list")
    @channels = Workspace.get("https://slack.com/api/conversations.list")
    @selected_recipient = nil
  end

  def self.get(url)
    response = HTTParty.get(url, query: {token: ENV['SLACK_TOKEN']})

    if response.code != 200 || response["ok"] == false
      raise SlackAPIError, "We encountered a problem: #{response["error"]}"
    end

    return response
  end

  def num_of_channels
    number = @channels["channels"].count
    return number
  end

  def list_channels
    i = 1

    channels["channels"].each do |channel|
      puts "Channel number #{i}'s name is #{channel["name"]}, their topic is '#{channel["topic"]["value"]}', it has #{channel["num_members"]} members and its id is #{channel["id"]}."
      i += 1
    end
    
  end

  def num_of_users
    number = users["members"].count
    return number
  end

  def list_users
    i = 1

    users["members"].each do |member|
      puts "User number #{i}'s username is #{member["name"]}, their name is #{member["real_name"]}, and id is #{member["id"]}."
      i += 1
    end
  end




  def name_or_id(type)
    puts "What information will you be providing? Please type 'name' or 'id'."
    answer = gets.chomp.downcase
  
    while answer != "name" && answer != "id"
      puts "Try again? Please type 'name' or 'id'."
      answer = gets.chomp.downcase
    end 
  
    # @TODO:  Refactor this.  Stop using parameters as variable names, lots of other duplication.  Jesus this is bad.
    if type == "user"
      if answer == "name"
        puts "Please provide the name:"
        provided_name = gets.chomp
        recipient = User.create(provided_name, "user_#{answer}")
        @selected_recipient = recipient
        puts "Thank you, I have noted your selection"
      elsif answer == "id"
        puts "Please provide the id:"
        provided_id = gets.chomp
        recipient = User.create(provided_id, "user_#{answer}")
        @selected_recipient = recipient
        puts "Thank you, I have noted your selection"
      end
    end 

    if type == "channel"
      if answer == "name"
        puts "Please provide the name:"
        provided_name = gets.chomp
        recipient = Channel.create(provided_name, "channel_#{answer}")
        @selected_recipient = recipient
        puts "Thank you, I have noted your selection"
      elsif answer == "id"
        puts "Please provide the id:"
        provided_id = gets.chomp
        recipient = Channel.create(provided_id, "channel_#{answer}")
        @selected_recipient = recipient
        puts "Thank you, I have noted your selection"
      end
    end 
  end
end

class SlackAPIError < StandardError ; end