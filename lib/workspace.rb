require "httparty"
require "dotenv"
require_relative "user"
require_relative "channel"

Dotenv.load

class Workspace

  attr_reader :channels, :users, :selected

  def initialize
    @channels = Channel.list_all
    @users = User.list_all
    @selected = ""
  end

  def select_channel
  end

  def select_user
  end

  def show_details
  end

  def send_message
  end

end