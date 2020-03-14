require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :channels, :selected
  
  def initialize
    user_response = User.get("https://slack.com/api/users.list")
    channel_response = User.get("https://slack.com/api/channels.list")
    users = 
    @users = []
    @channels = []
    @selected = selected
  end

  def select_channel
  end

  def select_user
  end

  def show_details
  end

  def send_message
  end
end
