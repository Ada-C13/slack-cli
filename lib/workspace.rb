require_relative 'user'
require_relative 'channel'


module SlackCli
  class Workspace

    attr_reader :users, :channels, :selected
    
    def initialize
      @users = User.get_all
      @channels = Channel.get_all
      @selected = nil    
    end

    def select_channel(name)
      @selected = @channels.select{|channel|channel.name == name}[0]
    end 

    def select_user(name)
      @selected = @users.select{|user|user.name == name}[0]
    end 

  end
end 