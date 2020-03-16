
require_relative 'receiver.rb'
require_relative 'channel.rb'
require_relative 'user.rb'
require_relative 'slack.rb'


module SlackCLI 
  class Workspace    
    attr_reader :users, :channels, :chosen

    def initialize
      @users = []
      @channels = []
      @chosen = nil
    end

    def choose_channel 
      sought = gets.chomp.downcase

      expose_channels 

      channels.each do |channel|
        if channel.name == sought || channel.id == sought
          @chosen = channel
          return "Selected #{channel.name}."
        end
      end
      return "Could not find channel."
    end

    def choose_user
      sought = gets.chomp.downcase 

      expose_users 

      users.each do |user|
        if user.name == sought || user.id == sought 
          @chosen = user
          return "Selected #{user.name}."  
        end 
      end 
      return "Could not find user."
    end 

    def expose_users
      @users = SlackCLI::User.show_all 
    end

    def expose_channels
      @channels = SlackCLI::Channel.show_all 
    end

    def deets
      if @chosen
        @chosen.summary
        return
      end
      puts "<No receiver selected>" 
    end

    def speak(body_talk)
      unless @chosen == nil
        @chosen.give_slack(body_talk)
      end 
    end 
  end 
end 