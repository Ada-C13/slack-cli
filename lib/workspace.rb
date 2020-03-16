require_relative "user"
require_relative "channel"

  class Workspace

    attr_reader :users, :channels, :selected

    def initialize(users: [], channels: [])
      @users = User.list_all
      @channels = Channel.list_all
      @selected = nil
    end 

    def select_channel
    end

    def select_user
    end 

    # displays workspace info to command line
    def show_details
    end 

    def send_message
    end 

  end 
