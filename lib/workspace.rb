require "httparty"
require "dotenv"
require_relative "channel"
require_relative "user"

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  #condense this method so checks the name and slack id in one loop?
  def select_user(name_or_slack_id)
    user = @users.find do |user|
      p user
      user.name == name_or_slack_id || user.slack_id == name_or_slack_id
    end

    return "no such user exists 😢" if user == nil

    @selected = user
    return "you've selected a user yay! 🤗"
  end

 select_user("UV60Q76GG")

  def select_channel(name_or_slack_id)
    channel = @channels.find do |channel|
      p channel 
      channel.name == name_or_slack_id || channel.slack_id == name_or_slack_id
    end

    return "no such channel exists 🤔" if channel == nil

    @selected = channel
    return "you've selected a channel yay! 🥳"
  end

  def details_of
    return "please select a user or channel to get details on" if @selected == nil

    return @selected.details
  end

  def text_me(message)
    return "Please write a message...." if message == nil
    return "you must choose a user or channel you want to send this message to" if @selected == nil
    channel = @selected.slack_id
    @selected.send_message(channel, message)
  end
end
