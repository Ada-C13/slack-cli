require 'httparty'
require 'dotenv'
require_relative 'user'
require_relative 'channel'
require_relative 'recipient'


Dotenv.load

class Workspace

  attr_reader :users, :channels, :selected 

  def initialize
    @users = UserRecipient.list_all
    @channels = ChannelRecipient.list_all
    @selected = selected

  end 
  def list_users
    return @users
  end

  def list_channels  
    return @channels
  end 

  def select_user(id)
    return UserRecipient.find(id)

  end 

  def select_channel(id)
    return ChannelRecipient.find(id)
  end 

  def get_details(recipient)
    if recipient.instance_of?(UserRecipient) || recipient.instance_of?(ChannelRecipient)
      return recipient.details
    else
      return "You have not chosen a user or channel, can't grab details for ya"
    end 
  end 

  def send_message

  end 

end 

