require "httparty"
require "dotenv"
require_relative "channel"
require_relative "user"

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
  end

  

end
