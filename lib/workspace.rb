require_relative "user"
require_relative "channel"

module Slack 
  class Workspace 

    attr_reader :users, :channels

    def initialize
      @users = Slack::User.list_all
      @channels = Slack::Channel.list_all
      @selected = nil
    end


    # Question: Do I need this?
    # (1) I should see information about how many channels and users were loaded  => [].length
    def num_of_users 
      @users.length
    end 

    def num_of_channels 
      @channels.length
    end 

    def select_channel 
    end 

    def select_user 
    end 

    def show_details 
    end 

    def send_message 
    end 
  end 
end 
