require_relative 'user'
require_relative 'channel'


module SlackCli
  

  class Workspace

    attr_reader :users, :channels
    
    def initialize
      @users = User.get_all
      @channels = Channel.get_all

    
    end

  end
end 