require 'HTTParty'
require 'dotenv'
require 'table_print'
require_relative 'workspace'
require_relative 'slack'
require_relative 'user'
require_relative 'recipient'

Dotenv.load

# Recipient contains:
#list
#select
#show_detail
#send_message

class Channel < Recipient

  attr_reader :topic, :member_count
  def initialize(name:, slack_id:, topic:, member_count:)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count 
  end 

  # get the data
  data = self.get("https://slack.com/api/channels.list")

  #parse the data, instantiate an object 
  channels = []
  data["channels"].each do |channel|
    channels << self.new(
              name: channel["name"],
              slack_id: channel["id"],
              topic: channel["topic"]["value"], 
              member_count: channel["num_members"]       
    )
  end
  return users

end

# def list_channels
#   query = {
#     token: ENV["SLACK_API_TOKEN"]
#   }
  
#   url = "https://slack.com/api/channels.list"
#   response = HTTParty.get(url, query: query)
  
#   response["channels"].each do |channel|
#     puts "Channel info:
#       name: #{channel["name"]},
#       topic: #{channel["topic"]["value"]},
#       member count: #{channel["num_members"]},
#       id: #{channel["id"]},
#       "
#   end 
# end


