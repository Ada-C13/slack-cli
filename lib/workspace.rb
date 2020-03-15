require 'httparty'
require_relative 'user'
require_relative 'channel'


class Workspace
  attr_reader :users, :channels, :selected
  
  def initialize
    @users = User.list_users
    @channels = Channel.list_channels
    @selected = nil 
  end
  
  
  def select_channel(user_channel)
    if channels.find { |channel| channel.name == user_channel } == nil && channels.find { |channel| channel.slack_id == user_channel } == nil
      return []
    elsif 
      @selected = channels.find { |channel| channel.name == user_channel }
    elsif
      @selected = channels.find { |channel| channel.slack_id == user_channel } 
    end
  end
  
  
  def select_user(user_name)
    if users.find { |user|  user.name == user_name } == nil && users.find { |user| user.slack_id == user_name } == nil
      return []
    elsif 
      @selected = users.find { |user| user.name == user_name }
    elsif
      @selected = users.find { |user| user.slack_id == user_name } 
    end
  end
  
  
  def show_details
    if @selected == nil
      return []
    end
    
    return @selected.details
  end
  
  
  def send_message(message)
    @selected.send_message(message)
  end
  
end