require_relative 'channel.rb'
require_relative 'user.rb'


class Workspace
  attr_reader :users, :channels, :list_of_users, :list_of_channels
  def initialize
    @users = User.list_all
    @channels = Channel.list_all
  end
end