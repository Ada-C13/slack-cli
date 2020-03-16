
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
      sought = gets.chomp 

      channels.each do |channel|
        if channel.name == sought || channel.id == sought
          @chosen = channel
          return "Your entry, #{chosen.name} has been chosen."
        end
      end 

      @chosen = nil
      return "That channel couldn't be recognized."
    end 

    def choose_user
      sought = gets.chomp

      users.each do |user|
        if user.name == sought || channel.id == sought 
          @chosen = channel
          return "Your entry, #{chosen.name} has been chosen." 
        end 
      end 
    end 

    def expose_users
      @users = SlackCLI::User.show_all 
    end

    # Play with this further
    def speak
      body_talk = gets.chomp
      @chosen.speak(body_talk)
    end 
  end 
end 