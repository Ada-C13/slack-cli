require_relative "user"
require_relative "channel"
module SlackApp
  class Workspace
    
    attr_reader :users, :channels, :selected
    attr_writer :selected 
    
    def initialize
      @users = User.list_all
      @channels = Channel.list_all
      @selected = nil 
      
    end
    
    def select_channel(choice)
      find_choice = @channels.find { |c| c.name == choice || c.slack_id == choice }
      @selected = find_choice
      if @selected != nil 
        return "#{selected.name} has been selected" 
      else 
        return "Sorry, I couldn't find that channel."
      end   
    end 
    
    def select_user 
      #just the name of the user (real name )
      
    end 
    
    def show_details 
      #show details about the selected (channel or user)
      
    end 
    
    def send_message 
    end 
    

    
  end 
end 

