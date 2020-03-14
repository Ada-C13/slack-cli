# create, call, and use User stuff and Channel stuff from here
# but User stuff and Channel stuff are defined in their own clases
require "dotenv"
require "httparty"

Dotenv.load

SLACK_TOKEN = ENV["SLACK_TOKEN"]

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.list_users
    @channels = Channel.list_channels
    @selected = []
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
end
