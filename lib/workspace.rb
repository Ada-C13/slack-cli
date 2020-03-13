require "httparty"
require_relative "channel"
require_relative "user"

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select_user(name_or_slack_id)
    user = @users.find do |user|
      user.name.downcase == name_or_slack_id.downcase || user.slack_id.downcase == name_or_slack_id.downcase
    end

    @selected = user unless user == nil 
  end

  def select_channel(name_or_slack_id)
    channel = @channels.find do |channel|
      channel.name.downcase == name_or_slack_id.downcase || channel.slack_id.downcase == name_or_slack_id.downcase
    end

    @selected = channel unless channel == nil
  end

  def details_of
    return @selected.details
  end

  def text_me(message)
    channel = @selected.slack_id
    request = @selected.send_message(channel, message)
    return false if request["okay"] == false
  end
end