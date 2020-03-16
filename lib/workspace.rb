require_relative 'channel'
require_relative 'user'

class Workspace

  attr_reader :users, :channels, :selected

  def initialize()
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def get_user_input
    gets.chomp
  end
  
  def select_user
    user_input = get_user_input

    users.each do |user|
      if user.name == user_input || user.slack_id == user_input
        @selected = user
        return "#{selected.name} has been selected"
      end
    end

    @selected = nil
    return "User could not be found."
  end

  def select_channel
    user_input = get_user_input

    channels.each do |channel|
      if channel.name == user_input || channel.slack_id == user_input
        @selected = channel
        return "#{selected.name} has been selected"
      end
    end

    @selected = nil
    return "Channel could not be found."
  end

  def show_details
    @selected.details
  end

  def send_message
    text = get_user_input

    @selected.send_message(text)
  end

end
