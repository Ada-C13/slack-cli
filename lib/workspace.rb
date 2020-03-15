require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :channels, :selected
  

  def initialize 
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end
#When I type select user, I should be able to supply a username or Slack ID. 
#The corresponding user should be the "selected" recipient.

def select_user(supply)
  @users.each do |user| # find user that matchs supply
    if user.name == supply
      @selected = user 
      return user
    elsif user.id == supply
      @selected = user 
      return user
    else
       @selected = nil
    end
  end
  "No such username found"
end

  #When I type select channel, I should be able to supply a channel 
  #name or Slack ID. The corresponding channel should be the "selected" recipient.

  def select_channel(supply)
    @channels.each do |channel| # find user that matchs supply
      if channel.name == supply
        @selected = channel
        return channel
      elsif channel.id == supply
        @selected = channel
        return channel
      else 
        @selected = nil
      end
    end
    "No such channel found"
  end
  

  #When I type details, the program should print out details for the currently selected recipient. 
  #What information is printed depends on whether it's a channel or a user.
  def show_details
    return @selected
  end

end