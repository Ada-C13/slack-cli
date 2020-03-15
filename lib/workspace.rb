require_relative 'channel'
require_relative 'user'

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select_channel
    input = gets.chomp

    channels.each do |channel|
      #search for the channel name or id
    end

    #accomodate for if it doesn't exist
  end

  def select_user
    #get the keyword
    input = gets.chomp

  end

  def show_details
    @selected.details
  end
  
  def send_message
    message = gets.chomp

    @selected.send_message(message)
  end
end