require_relative "user"
require_relative "channel"

  class Workspace

    attr_reader :users, :channels, :selected

    def initialize(users: [], channels: [])
      @users = User.list_all
      @channels = Channel.list_all
      @selected = nil
    end 

    def select_user(requested_user)
      users.each do |user|
        if user.name == requested_user || user.slack_id == requested_user
          @selected = user
          return "User \"#{selected.real_name}\" has been selected."
        end
      end 

      return "Sorry, user \"#{requested_user}\" does not exist in this workspace."
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

    # displays workspace info to command line based on selected recipient
    def display_details
      return @selected.details
    end 

    # posts a message in the selected channel in workspace 
    def send_message(message_text)
      @selected.send_message(message_text)
    end 

  end 
