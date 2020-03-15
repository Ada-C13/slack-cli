require "httparty"
require "dotenv"
require "awesome_print"

require_relative "recipient"
require_relative "channel"
require_relative "user"

class Workspace

  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = ""
  end

  def select_user(user_id_or_username)
    user_profile = @users.find {|user| 
      user.slack_id == user_id_or_username || 
      user.name == user_id_or_username
    }
    if user_profile == nil
      return nil
    else
      return @selected = user_profile
    end
  end

  def select_channel(channel_id_or_channelname)
    channel_profile = @channels.find {|channel| 
      channel.slack_id == channel_id_or_channelname || 
      channel.name == channel_id_or_channelname
    }
    if channel_profile == nil
      return nil
    else
      return @selected = channel_profile
    end 
  end

  def show_details
    if @selected != ""
      return @selected.details
    else
      return @selected
    end
  end

  
end

