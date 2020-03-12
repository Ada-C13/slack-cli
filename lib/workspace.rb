
class Workspace
  attr_reader :users, :channels, :selected
  
  def initialize
    @users = SlackApp::User.list_all #class method
    @channels = SlackApp::Channel.list_all
    @selected = nil #selected will hold the id or name of a channel or user, that way i can give the details about it 
  end

  def select_channel 
    #loop through a list of channels and get the one they choose
    #just the name of the channel 
    # all_channels = [] 
    # @channels.each_with_index do |channel, i|
    #   slack_id = 
    #   name = channel["channels"][i]["name"]
    #   topic = 
    #   member_count = 
    #   channel = SlackApp::Channel.new(slack_id, name, topic, member_count)

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

#workspace is our drive code 
#send message should know does have any parameters attached to it 
#what is the selected for? select is going to be channel or user / selected recipient 
#


# all_channels = [] 
# @channels.each_with_index do |channel, i|
#   slack_id = 
#   name = channel["channels"][i]["name"]
#   topic = 
#   member_count = 
#   channel = SlackApp::Channel.new(slack_id, name, topic, member_count)