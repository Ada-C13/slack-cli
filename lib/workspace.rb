require 'table_print'
require_relative 'user'
require_relative 'channel'
require_relative 'slack_api_error'


class Workspace
  attr_reader :users, :channels
  attr_accessor :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil 
  end

  def list_users
    raise SlackAPIError, "No users were loaded from the API." if @users.length == 0
    tp @users, :slack_id, :name, :real_name
    return true
  end

  def list_channels
    raise SlackAPIError, "No channels were loaded from the API." if @channels.length == 0
    tp @channels, :slack_id, :name, :topic, :member_count
    return true
  end

  def select_user(id: nil, username: nil)
    if id
      @selected = @users.find{|user|user.slack_id == id}
    elsif username
      @selected = @users.find{|user|user.name == username}
    else
      raise ArgumentError, 'SLACK ID or username is required'
    end

    return @selected
  end

  def select_channel(id: nil, name: nil)
    if id
      @selected = @channels.find{|channel|channel.slack_id == id}
    elsif name
      @selected = @channels.find{|channel|channel.name == name}
    else
      raise ArgumentError, 'SLACK ID or channel name is required'
    end

    return @selected
  end


  # def send_message
  #   if @selected is a channel
  #     @selected.send_message #but channel#send_message needs argument??
  #   elsif @selected is a users
  #     @selected.send_message #but channel#send_message needs argument??
  #   end
  # end
end