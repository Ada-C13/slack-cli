require_relative "user"
require_relative "channel"

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = ""
  end

  def list_users
    @users.map { |user| "slack_id: #{user.slack_id}, user: #{user.name}, username: #{user.username}"}
  end

  def list_channels
    @channels.map { |channel| "slack_id: #{channel.slack_id}, channel: #{channel.name}, topic: #{channel.topic}, member count: #{channel.member_count}"}
  end

  def select_user(identifier)
    user = @users.find { |user| user.slack_id == identifier || user.username == identifier }
    if !user.nil?
      @selected = user
    end
  end

  def select_channel(identifier)
    channel = @channels.find { |channel| channel.slack_id == identifier || channel.name == identifier }
    if !channel.nil?
      @selected = channel
    end
  end

end