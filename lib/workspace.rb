require_relative 'channel'
require_relative 'user'

class Workspace

  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil

  end
  
  def select_user
    user_input = get_user_input

    users.each do |user|
      if user.name == user_input
        @selected = user
        return "#{@selected.name} has been selected"
      end
    end

    @selected = nil
    return "User could not be found."
  end

  def get_user_input
    gets.chomp
  end

  def select_channel
    user_input = get_user_input

    channels.each do |channel|
      if channel.name == user_input
        @selected = channel
        return "#{@selected.name} has been selected"
      end
    end

    @selected = nil
    return "Channel could not be found."
  end

  def show_details
    raise NotImplementedError, "Code this method." 
  end

  def send_message
    raise NotImplementedError, "Code this method."
  end

end
