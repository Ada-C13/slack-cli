require 'httparty'
require 'dotenv'
require_relative 'user'
require_relative 'channel'


Dotenv.load

class Workspace

  attr_reader :users, :channels, :selected 

  def initialize
    @users = UserRecipient.list_all
    @channels = ChannelRecipient.list_all
    @selected = selected

  end 
  def list_users
    #TODO a prettier way to print 
    return @users
  end

  def list_channels 
    #TODO a prettier way to print 
    return @channels
  end 

  def select_user

  end 

  def select_channel

  end 

end 

