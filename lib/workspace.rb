require_relative 'user'
require_relative 'channel'
require 'dotenv'

module SlackCli
  class Workspace
    attr_reader :users, :channels
    attr_accessor :selected
    
    def initialize()
      Dotenv.load(__dir__ + "/" + "../.env") #https://github.com/bkeepers/dotenv
      @users = SlackCli::User.load_all("#{ENV['BASE_URL'] + ENV['SUB_USER_URL'] + "token=#{ENV['SLACK_TOKEN']}"}")        
      @channels = SlackCli::Channel.load_all("#{ENV['BASE_URL'] + ENV['SUB_CHANNEL_URL'] + "token=#{ENV['SLACK_TOKEN']}"}")
      @selected = nil
    end #initialize

  #--------------------------Class Methods ------------------------

    #Returns all valid user id and name
    # inputs: aMode that's either "user" or "channel"
    def valid_inputs_id_names(aMode)
      valid_inputs = []
      if aMode == "user"
        self.users.each do |user|
          valid_inputs << user.id
          valid_inputs << user.name
        end
      elsif aMode == "channel"
        self.channels.each do |channel|
          valid_inputs << channel.id
          valid_inputs << channel.name
        end
      end
    return valid_inputs
    end

  #----------------------------------------------------------------

    #finds a user
    #input: aUser_input
    #Returns a found user
    def find_user(aUser_input)
      found_user = nil
      self.users.each do |user|
        if (aUser_input == user.id) || (aUser_input == user.name)
          return user
        end
      end
      return found_user
    end

  #----------------------------------------------------------------

    #finds a channel
    #input: aUser_input
    #Returns a found channel
    def find_channel(aUser_input)
      found_channel = nil
      self.channels.each do |channel|
        if (aUser_input == channel.id) || (aUser_input == channel.name)
          return channel
        end
      end
      return found_channel
    end
    #----------------------------------------------------------------
  end #class
end #module

test_workspace = SlackCli::Workspace.new
# test_workspace.users.each do |user|
#   puts user.real_name  
# end

name = test_workspace.find_user("cheese")
puts name

