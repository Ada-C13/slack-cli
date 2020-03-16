require_relative "user"
require_relative "channel"

  class Workspace

    attr_reader :users, :channels, :selected

    def initialize(users: [], channels: [])
      @users = User.list_all
      @channels = Channel.list_all
      @selected = nil
    end 

    def select_channel(requested_channel)
      channels.each do |channel|
        if channel.name == requested_channel || channel.slack_id == requested_channel
          @selected = channel
          return "Channel titled \"#{selected.name}\" has been selected."
        end
      end 

      return "Sorry, channel \"#{requested_channel}\" does not exist in this workspace."
    end

    def select_user
    end 

    # displays workspace info to command line
    def show_details
    end 

    def send_message
    end 

  end 
