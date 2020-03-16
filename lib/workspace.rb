# create, call, and use User stuff and Channel stuff from here
# but User stuff and Channel stuff are defined in their own clases
require "dotenv"
require "httparty"
require "pry"
require_relative "recipient"
require_relative "channel"
require_relative "user"

Dotenv.load

SLACK_TOKEN = ENV["SLACK_TOKEN"]

class Workspace
  attr_reader :users, :channels
  attr_accessor :selected

  def initialize
    @users = User.list_users
    @channels = Channel.list_channels
    @selected = []
  end

  # - When I type `details`, the program should print out details for the currently selected recipient. What information is printed depends on whether it's a channel or a user.
  #   - If no recipient is currently selected, the program should let me know and return to the main command prompt.

  def show_details
    @selected.details
  end

  def select_channel(selection)
    @selected = @channels.find do |channel| channel.slack_id == selection || channel.name == selection end
    return @selected
  end

  def list_channels
    url = "https://slack.com/api/channels.list?token=#{SLACK_TOKEN}&pretty=1"
    response = HTTParty.get(url)
    channels_list = []
    # looking for channels in response
    response["channels"].each do |channel|
      channels_list << channel["name"]
    end
    return channels_list
  end

  def select_user(selection)
    @selected = @users.find do |user| user.slack_id == selection || user.name == selection end
    return @selected
  end

  def list_users
    url = "https://slack.com/api/users.list?token=#{SLACK_TOKEN}&pretty=1"
    response = HTTParty.get(url)
    users_list = []
    # looking for user in response
    response["members"].each do |user|
      users_list << ([user["id"], user["profile"]["real_name"], user["name"]])
    end
    return users_list
  end
end
