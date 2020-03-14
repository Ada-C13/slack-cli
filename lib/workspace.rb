require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :channels
  attr_accessor :selected
  
  def initialize

    @users = User.list_all

    @channels = Channel.list_all

    @selected = selected
  end

  def select_channel(channel)
    @channels.each do |channel_obj|
      if channel_obj.name == channel || channel_obj.slack_id == channel
        @selected = channel_obj
        return channel_obj 
      end
    end
    return "Channel not found!"
  end

  def select_user(user)
    @users.each do |user_obj|
      if user_obj.name == user || user_obj.slack_id == user
        @selected = user_obj
        return user_obj 
      end
    end
    return "User not found!"
  end

  def show_details
    @selected
  end

  def send_message
  end
end

workspace = Workspace.new
p workspace.channels[0].topic