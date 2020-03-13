# create, call, and use User stuff and Channel stuff from here
# but User stuff and Channel stuff are defined in their own clases

require "dotenv"
require "httparty"
require_relative "channel"
require_relative "user"
require_relative "recipient"

Dotenv.load

SLACK_TOKEN = ENV["SLACK_TOKEN"]

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_users
    @channels = Channel.list_channels

    # need to use Recipient class here???
    @selected = nil
  end
end
