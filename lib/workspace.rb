#coded along with Devin for Wave 1

require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :selected_user, :channels, :selected_channel

  def initialize()
    @users = User.list_all
    @selected_user = nil
    @channels = Channel.list_all
    @selected_channel = nil
  end

  def select_user

  end

  def select_channel
  end

  def show_details
  end

  def send_message
  end
  
end

