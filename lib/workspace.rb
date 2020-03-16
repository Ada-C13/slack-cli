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
    my_channel = gets.chomp

    channel = @channels.find { |c| (c.name == my_channel) || (c.slack_id == my_channel) }
    
    if channel
      @selected = channel
      return "#{channel.name} is now selected."
    else
      return "#{my_channel} does not exist"
    end
  end

  def select_user
    my_user = gets.chomp

    user = @users.find { |u| (u.username == my_user) || (u.real_name == my_user) }

    if user
      @selected = user
      return "\n#{user.real_name} is now selected."
    else
      return "\n#{my_user} does not exist"
    end
  end

  def show_details
    @selected.details
  end
  
  def send_message
    my_message = gets.chomp

    @selected.send_message(my_message)
  end
end