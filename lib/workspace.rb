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

  def select_channel(param)
    raise ArgumentError, "Channel name or id must be a string" unless param.is_a?(String)

    @selected = @channels.find { |channel| channel.id == param || channel.name == param }
    raise ArgumentError, "Channel not found" if @selected == nil
  end

  def select_user(param)
    raise ArgumentError, "User name or id must be a string" unless param.is_a?(String)

    @selected = @users.find { |user| user.id == param || user.name == param }
    raise ArgumentError, "User not found" if @selected == nil
  end

  def show_details
    raise ArgumentError, "Nothing is selected" if @selected == nil
    return @selected.details
  end

  def send_message

  end

end # Class
