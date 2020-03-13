require_relative 'user'
require_relative 'channel'
require 'dotenv'

module SlackCli
  class Workspace
    attr_reader :users, :channels, :selected
    
    def initialize()
      Dotenv.load(__dir__ + "/" + "../.env") #https://github.com/bkeepers/dotenv
      @users = SlackCli::User.load_all("#{ENV['BASE_URL'] + ENV['SUB_USER_URL'] + "token=#{ENV['SLACK_TOKEN']}"}")        
      @channels = SlackCli::Channel.load_all("#{ENV['BASE_URL'] + ENV['SUB_CHANNEL_URL'] + "token=#{ENV['SLACK_TOKEN']}"}")
      @selected = nil
    end #initialize


    def select_channel
    end

    def select_user
    end

    def show_details
    end

    def send_message
    end


    
  end #class
end #module

# test_workspace = SlackCli::Workspace.new
# test_workspace.users.each do |user|
#   puts user.real_name  
# end
