require "httparty"
require "dotenv"
require "awesome_print"

require_relative "channel"
require_relative "user"

class Workspace

  attr_reader :users, :channels

  def initialize
    @users = User.list_all # arrays of users
    @channels = Channel.list_all # arrays of channels
  end

end