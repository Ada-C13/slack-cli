require "httparty"
require "dotenv"
require 'json'
require_relative "user"
require_relative "channel"

Dotenv.load

BASE_URL = "https://slack.com/api/"
API_KEY = ENV["SLACK_API_TOKEN"]
USER_URL = "#{BASE_URL}/users.list"
CHANNEL_URL = "#{BASE_URL}/conversations.list"


class Workspace

  attr_reader :channels, :users, :selected

  def initialize
    @channels = []
    @users = []
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