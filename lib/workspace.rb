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

    def num_of_channels
      number = @channels["channels"].count
      return number
    end
    
    def num_of_users
      number = users["members"].count
      return number
    end

    def list_users(workspace)
      users = workspace.users
      i = 1

      users["members"].each do |member|
        puts "User number #{i}'s username is #{member["name"]}, their name is #{member["real_name"]}, and id is #{member["id"]}."
        
        i += 1
      end
      #tp workspace.users, :name,:real_name, :slack_id 
    end

    def list_channels(workspace)
      channels = workspace.channels
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
        Recipient.details(recipient)
        
      
      elsif answer == "id"
        puts "Please provide the id:"
        provided_id = gets.chomp
        recipient = Recipient.create_recipient_from_id(provided_id,type)
        Recipient.details(recipient)
      end
    end

   
  end

#end