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

    channel = @channels.find { |c| c.name == my_channel }

    channel ? (return channel) : (raise ArgumentError, "#{my_channel} does not exist")
  end

  def select_user
    my_user = gets.chomp

    user = @users.find { |u| u.real_name == my_user }

    user ? (return user) : (raise ArgumentError, "#{my_user} does not exist")
  end

  def show_details
    @selected.details
  end
  
  def send_message
    my_message = gets.chomp

    @selected.send_message(my_message)
  end
end