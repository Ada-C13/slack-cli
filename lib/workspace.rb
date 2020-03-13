require 'httparty'

module SlackApp
  class Workspace
    
    attr_reader :users, :channels, :selected
    attr_writer :selected 
    
    def initialize
      @users = nil #initalize_users()
      @channels = initalize_channels()
      @selected = nil #selected will hold the id or name of a channel or user, that way i can give the details about it 
      
    end
    
    def select_channel 
      
    end 
    
    def select_user 
      #just the name of the user (real name )
      
    end 
    
    def show_details 
      #show details about the selected (channel or user)
      
    end 
    
    def send_message 
    end 
    
    # def initalize_users
    #   response = SlackApp::Recipient.get("users.list")
    #   result = []
    #   response["users"]
    
    # end 
    def initalize_channels 
      response = 
      response = SlackApi.get_channels();
      response["channels"].each do |channel|
        @channels << SlackApp::Channel.new(channel["id"], channel["name"], channel["topic"]["value"], channel["num_members"])
      end
      puts response
      return @channels
    end
    
  end 
end 

