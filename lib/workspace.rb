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
    @selected = @users.find {|user| 
      user.slack_id == user_id_or_username || 
      user.name == user_id_or_username
    }
    return @selected
  end

  def select_channel(channel_id_or_channelname)
    @selected = @channels.find {|channel| 
      channel.slack_id == channel_id_or_channelname || 
      channel.name == channel_id_or_channelname
    }
    return @selected 
  end

  def show_details
    if @selected != ""
      return @selected.details
    else
      return @selected
    end
  end

  def prompt_options
    puts "6 options: list users, list channels, select user, select channel, details, or quit:"
    input = gets.chomp.downcase
    return input
  end
end

