require_relative 'recipient'
require 'table_print'
require 'dotenv'
require 'httparty'
Dotenv.load

KEY = ENV["SLACK_TOKEN"]

#module Slack
  class Workspace
  attr_reader :channels, :users
    def initialize
      channels_url = "https://slack.com/api/conversations.list"
      @channels = HTTParty.get(channels_url, query: {token: KEY})

      users_url = "https://slack.com/api/users.list"
      @users = HTTParty.get(users_url, query: {token: KEY})
    end

    def options
      puts "What would you like to do? Please type one of the following:\n- list users\n- list channels\n- select user\n- select channel\n- details\n- quit"
      user_input = gets.chomp.downcase
      valid_inputs = ["list users", "list channels", "select user", "select channel", "details", "quit"]
  
      until valid_inputs.include?(user_input)
        puts "Please type a valid response :\n- list users\n- list channels\n- select user\n- select channel\n- details\n- quit"
        user_input = gets.chomp.downcase
      end
  
      case user_input
      when "list users"
        workspace = Workspace.new  #how do i get my code so i dont need this?
        workspace.list_users
        options
      when "list channels"
        workspace = Workspace.new
        workspace.list_channels
        options
      when "select user"
        user_info = Workspace.new.name_or_id("user")
        options
      when "select channel"
        channel_info = Workspace.new.name_or_id("channel")
        options
      when "details"
  
      when "quit"
        return
      end
      return
    end

    def num_of_channels
      number = @channels["channels"].count
      return number
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
      #tp workspace.users, :name,:real_name, :slack_id 
    end

    def list_channels
      i = 1
      channels["channels"].each do |channel|
       puts "Channel number #{i}'s name is #{channel["name"]}, their topic is '#{channel["topic"]["value"]}', it has #{channel["num_members"]} members and its id is #{channel["id"]}."
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
    
      if answer == "name"
        puts "Please provide the name:"
        provided_name = gets.chomp
        recipient = Recipient.create_recipient_from_name(provided_name,type)
        puts "Thank you, I have noted your selection"
        options
      elsif answer == "id"
        puts "Please provide the id:"
        provided_id = gets.chomp
        recipient = Recipient.create_recipient_from_id(provided_id,type)
        puts "Thank you, I have noted your selection"
        options
      end
    end

   
  end

#end