require_relative "user"
require_relative "channel"

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
  end

  def list_users
    @users.map { |user| "slack_id: #{user.slack_id}, user: #{user.username}, username: #{user.name}"}
  end

  def list_channels
    @channels.map { |channel| "slack_id: #{channel.slack_id}, channel: #{channel.name}, topic: #{channel.topic}, member count: #{channel.member_count}"}
  end

end