require_relative 'channel.rb'
require_relative 'user.rb'


class Workspace
  attr_reader :users, :channels
  def initialize
    @users = []
    @channels = []
  end
end