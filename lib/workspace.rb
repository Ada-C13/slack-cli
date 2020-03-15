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
    # inputs: slack id's (:id), need list of name (:name)
    def valid_inputs_id_names()
    valid_inputs = []
      self.users.each do |user|
        valid_inputs << user.id
        valid_inputs << user.name
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
  end #class
end #module

test_workspace = SlackCli::Workspace.new
# test_workspace.users.each do |user|
#   puts user.real_name  
# end

name = test_workspace.find_user("cheese")
puts name

