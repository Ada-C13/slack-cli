require_relative "user"
require_relative "channel"

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil 
  end

  def select_user(identifier)
    user = @users.find { |user| 
      user.slack_id == identifier || user.name == identifier }

    if !user.nil?
      @selected = user
    end
  end

  def select_channel(identifier)
    channel = @channels.find { |channel| 
      channel.slack_id == identifier || channel.name == identifier }

    if !channel.nil?
      @selected = channel
    end
  end

  def show_details
    if @selected != nil 
      @selected.details 
    else
      "No recipient is selected"
    end
  end

  def send_message
    if @selected != nil 
      puts "Enter a message here:"
      message = gets.chomp
      @selected.send_message(message)
    else
      "No recipient is selected"
    end
  end
end
