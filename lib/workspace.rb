require "httparty"
require "dotenv"
require_relative "user"
require_relative "channel"
require 'table_print'

Dotenv.load

class Workspace

  attr_reader :channels, :users, :selected

  def initialize
    @channels = Channel.list_all
    @users = User.list_all
    @selected = ""
  end

  def select_channel(channel_name)
    @channels.each do |channel|
      if channel.name == channel_name || channel.slack_id == channel_name
        @selected = channel
        puts "\n You have selected #{channel.name}"
        break
      else
        @selected = nil
      end
    end
    if @selected == nil
      puts "The channel you just entered is not valid!!"
    end
  end

  def select_user(user_name)
    @users.each do |user|
      if user.real_name == user_name || user.slack_id == user_name || user.name == user_name
        @selected = user
        puts "\n You have selected #{user.real_name}"
        break
      else
        @selected = nil
      end
    end
    
    if @selected == nil
      puts "The user you just entered is not valid!!!"
    end
  end

  def show_details
    if @selected.class == Channel
      tp @selected, "name", "topic", "memeber_count", "slack_id"
    elsif 
      @selected.class == User
      tp @selected, "slack_id", "name", "real_name","status_emoji"
    end 
  end

  def send_message(message)
    response = @selected.send_message(message)
    return response.code == 200 && response.parsed_response["ok"]
  end 

  def set_profile_setting(name, emoji)
    response = @selected.set_user_profile_name(name, emoji)
    return response.code == 200 && response.parsed_response["ok"]
  end

end