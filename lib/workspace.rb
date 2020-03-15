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
      find_choice = @channels.find { |c| c.name == choice.downcase || c.slack_id == choice.upcase }
      @selected = find_choice
      if @selected != nil 
        return "#{selected.name} has been selected" 
      else 
        return "Sorry, I couldn't find that channel."
      end   
    end 
    
    def select_user(choice) 
      find_choice = @users.find { |u| u.name == choice.downcase || u.slack_id == choice.upcase }
      @selected = find_choice
      if @selected != nil 
        return "#{selected.name} has been selected" 
      else 
        return "Sorry, I couldn't find that channel."
      end 
    end 
    
    def show_details 
      @selected.details 
    end 
    
    def send_message 
      msg_text = gets.chomp
      @selected.send_message(msg_text)
    end 
  end 
end 

