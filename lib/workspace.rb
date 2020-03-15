require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :channels, :selected
  # attr_writer :selected
  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = ""
  end

  def select_channel(string)
    @selected = @channels.find { |channel| channel.slack_id.upcase == string }
  end

  def select_user(string)
    @users.each do |user|
      @selected = user if user.slack_id.upcase == string
    end
  end

  def show_details
    return @selected.details
  end

  def send_message(message)
    @selected.send_message(message)
  end

  
end