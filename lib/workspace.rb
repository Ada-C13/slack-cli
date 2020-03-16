require_relative 'user'
require_relative 'channel'

class Workspace
  # Generator
  attr_reader :users, :channels, :selected

  # Constructor
  def initialize
    @users    = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  # Method to select a channel
  def select_channel(param)
    raise ArgumentError, "Channel name or id must be a string" unless param.is_a?(String)

    @selected = @channels.find { |channel| channel.id == param || channel.name == param }
    raise ArgumentError, "Channel not found" if @selected == nil
  end

  # Method to select a user
  def select_user(param)
    raise ArgumentError, "User name or id must be a string" unless param.is_a?(String)

    @selected = @users.find { |user| user.id == param || user.name == param }
    raise ArgumentError, "User not found" if @selected == nil
  end

  # Method to show details of the selected user or channel
  def show_details
    raise ArgumentError, "Nothing is selected" if @selected == nil
    return @selected.details
  end

  # Method to send a message to the selected user or channel
  def send_message(msg)
    raise ArgumentError, "Nothing is selected" if @selected == nil
    return @selected.send_message(msg)
  end

end # Class
