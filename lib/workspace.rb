require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :channels, :selected

  def initialize 
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end


  # When I type select user, I should be able to supply a username or Slack ID. 
  # The corresponding user should be the "selected" recipient.
  def select_user(user_input)
    @users.each do |user| 
      if user.name == user_input
        @selected = user    
      elsif user.id == user_input
        @selected = user 
      end
    end
    return @selected
  end


  # When I type select channel, I should be able to supply a channel 
  # name or Slack ID. The corresponding channel should be the "selected" recipient.
  def select_channel(user_input)
    @channels.each do |channel|
      if channel.id == user_input
        @selected = channel
      elsif channel.name == user_input
        @selected = channel
      end
    end
    return @selected
  end

  
  # When I type details, the program should print out details for the currently selected recipient. 
  # What information is printed depends on whether it's a channel or a user.
  def show_details
    return @selected.details 
  end


  # When I type send message, if a recipient is selected the program 
  # should ask me to type out a message, which will be sent to that recipient.
  # If no recipient is currently selected, the program should let me know and 
  # return to the main command prompt.
  def send_message(message)
    if @selected != nil
      @selected.send_message(message, @selected) 
    end 
  end
end
