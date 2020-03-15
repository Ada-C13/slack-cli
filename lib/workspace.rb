
require 'dotenv'
require 'httparty'

require_relative 'recipient'
# require_relative 'user'
# require_relative 'channel'

# @TODO: Load environment objects and key in an actual method
Dotenv.load

KEY = ENV["SLACK_TOKEN"]

class Workspace
  attr_accessor :channels, :users, :selected_recipient, :selected_type

  def initialize
    @users = Workspace.get("https://slack.com/api/users.list")
    @channels = Workspace.get("https://slack.com/api/conversations.list")
    @selected_recipient = nil
    @selected_type = nil
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



  def send_message_if_selected
    if selected_recipient != nil
      puts "Lets send a message!"
      puts "Please type the message you want to send."
      message = gets.chomp
      selected_recipient.send_message(message, selected_recipient)
    else 
      puts "You don't have any recipient selected"
    end
  end

  def name_or_id(type)  # TODO break this up into methods select channel and select user to better match given design
    puts "Please provide a user name or ID for your channel or user"
    answer = gets.chomp

    if type == "user"
      users["members"].each do |member|
        if member["name"] == answer
          @selected_recipient = Recipient.new(member["name"],member["id"])
          @selected_type = "user"
          puts "Thank you, I have noted your selection"
          return
        elsif member["id"] == answer
          @selected_recipient = Recipient.new(member["name"],member["id"])
          @selected_type = "user"
          puts "Thank you, I have noted your selection"
          return
        end
      end
      puts "You did not provide a vaild recipient"
      return
    elsif type == "channel"
      channels["channels"].each do |channel|
        if channel["name"] == answer
          @selected_recipient = Recipient.new(channel["name"],channel["id"])
          @selected_type = "channel"
          puts "Thank you, I have noted your selection"
          return
        elsif channel["id"] == answer
          @selected_recipient = Recipient.new(channel["name"],channel["id"])
          @selected_type = "channel"
          puts "Thank you, I have noted your selection"
          return
        end
      end
      puts "You did not provide a vaild recipient"
      return
    end 
  end
  
 # while answer != "name" && answer != "id"
    #   puts "Try again? Please type 'name' or 'id'."
    #   answer = gets.chomp.downcase
    # end 

    # @TODO:  Refactor this.  Stop using parameters as variable names, lots of other duplication.  Jesus this is bad.
    # if type == "user"
    #   if answer == "name"
    #     puts "Please provide the name:"
    #     provided_name = gets.chomp
        # recipient = User.create(provided_name, "user_#{answer}")
        # @selected_recipient = recipient
      #   puts "Thank you, I have noted your selection"
      # elsif answer == "id"
      #   puts "Please provide the id:"
      #   provided_id = gets.chomp
        # recipient = User.create(provided_id, "user_#{answer}")
        # @selected_recipient = recipient
  #       puts "Thank you, I have noted your selection"
  #     end
  #   end 

  #   if type == "channel"
  #     if answer == "name"
  #       puts "Please provide the name:"
  #       provided_name = gets.chomp
  #       recipient = Channel.create(provided_name, "channel_#{answer}")
  #       @selected_recipient = recipient
  #       puts "Thank you, I have noted your selection"
  #     elsif answer == "id"
  #       puts "Please provide the id:"
  #       provided_id = gets.chomp
  #       recipient = Channel.create(provided_id, "channel_#{answer}")
  #       @selected_recipient = recipient
  #       puts "Thank you, I have noted your selection"
  #     end
  #   end 
  # end
end

class SlackAPIError < StandardError ; end