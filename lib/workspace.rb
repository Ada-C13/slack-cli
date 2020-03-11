require 'dotenv'
require 'httparty'

Dotenv.load

SLACK_TOKEN = ENV['SLACK_TOKEN']


class Workspace
  attr_reader :users, :channels
  
  def initialize
    @users = [] # will be array of user objects
    @channels = [] # will be array of channel objects
  end
  
  # this method will list all the channels!
  # looking at "channels" in response
  # for each thing in channels (channel), look at the thing labelled "name", shove that into the array
  def list_channels
    url = "https://slack.com/api/channels.list?token=#{SLACK_TOKEN}&pretty=1"
    response = HTTParty.get(url)
    
    channel_list = []
    response['channels'].each do |channel|
      channel_list << channel["name"]
    end
    
    return channel_list
  end
  
end
