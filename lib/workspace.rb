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
      channels.find do |channel|
        if channel.name.casecmp?(user_channel)
          @selected = channel
        end
      end
    elsif
      channels.find do |channel|
        if channel.slack_id.casecmp?(user_channel)
          @selected = channel
        end
      end
    end
  end
  
  
  def select_user(user_name)
    if users.find { |user|  user.name == user_name } == nil && users.find { |user| user.slack_id == user_name } == nil
      return []
    elsif 
      users.find do |user| user.name == user_name
        if user.name.casecmp?(user_name)
          @selected = user
        end
      end
    elsif
      users.find do |user| user.name == user_name
        if user.slack_id.casecmp?(user_name)
          @selected = user
        end
      end
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