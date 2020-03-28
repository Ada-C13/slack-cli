require_relative 'user'
require_relative 'channel'
require_relative 'recipient'

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select_channel(input)
    @selected = @channels.find { |channel| channel.name == input.downcase || channel.slack_id == input.upcase}
  end

  def select_user(input)
    @selected = @users.find { |user| user.name == input.downcase || user.slack_id == input.upcase}
  end

  def show_details
    return @selected.details
  end

  def send_message(message)
    return @selected.send_message(message)
  end
end