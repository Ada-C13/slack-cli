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
    @selected = UserRecipient.find(id)
    return @selected
  end 

  def select_channel(id)
    @selected = ChannelRecipient.find(id)
    return @selected
  end 

  def get_details
    if @selected.instance_of?(UserRecipient) || @selected.instance_of?(ChannelRecipient)
      return @selected.details
    else
      return "You have not chosen a user or channel, can't grab details for ya"
    end 
  end 

  def send_message(message)
    if selected.instance_of? UserRecipient
      @selected.send_message(message)
    elsif selected.instance_of? ChannelRecipient
      @selected.send_message(message)
    end 
  end 

end 

