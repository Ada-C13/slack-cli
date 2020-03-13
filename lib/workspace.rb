require_relative 'user'
require_relative 'channel'


module SlackCli

  class Workspace

    attr_reader :users, :channels
    attr_accessor :selected
    
    def initialize
      @users = User.list_all
      @channels = Channel.list_all
      @selected = nil    
    end

    def select_channel(name)
      @selected = @channels.select{|channel|channel.name == name}[0]
    end 

    def select_user(name)
      @selected = @users.select{|user|user.name == name}[0]
    end 

    def show_details
      return @selected.show_details
    end 

  end
end 