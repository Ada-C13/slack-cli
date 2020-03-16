#coded along with Devin for Wave 1

require_relative 'user'
require_relative 'channel'
require 'dotenv'
Dotenv.load

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select_user


  end

  def select_channel
  end

  def show_details
  end

  def send_message(message)
    Recipient.send_message(message, @selected)
  end
  
end

