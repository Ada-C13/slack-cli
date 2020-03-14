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

=begin
  def create_users
    query = {
      token: API_KEY
    }
    puts API_KEY
    resp = HTTParty.get(USER_URL, query: query)
    index = 0
    resp.parsed_response["members"].each do |user|
      @users[index] = User.new(user["profile"]["real_name"], user["profile"]["status_text"], user["profile"]["status_emoji"])
      index += 1
    end
  end

  def create_channels
    query = {
      token: API_KEY
    }
    puts API_KEY
    resp = HTTParty.get(CHANNEL_URL, query: query)
    index = 0
    resp.parsed_response["channels"].each do |channel|
      @channels[index] = User.new(channel["name"], channel["topic"]["value"], channel["num_members"])
      index += 1
    end
  end
=end

end