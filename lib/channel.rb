require_relative 'recipient'

class Channel < Recipient
  attr_reader :topic, :member_count
  
  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name) 
    @topic = topic 
    @member_count = member_count
  end
  
  
  # def details
  
  # end
  
  def self.list_channels
    # response received from get_everthing method in Recipient
    response = Recipient.get_everything("channels.list")
    # if response["ok"] != true
    # raise ERROR
# 
    all_channels_list = []

    response["channels"].each do |channel|
      slack_id = channel["id"]
      name = channel["name"]
      topic = channel["topic"]["value"]
      member_count = channel["members"].length
      
      all_channels_list << Channel.new(slack_id, name, topic, member_count)
    end
    
    return all_channels_list
  end
  
  
  # class Channel < Recipient
  #   BASE_URL = "https://slack.com/api/"
  #   def self.list_channels
  #     response = Recipient.get("channels.list")
  #     channel_list = []
  #     if response["ok"] != true
  #       raise SlackAPI::SlackError, "There was an error. The error message is #{response["error"]}"
  #     else
  #       response["channels"].each do |channel|
  #         channel_list << { "name" => channel["name"], "topic" => channel["topic"]["value"], "member count" => channel["members"].length, "id" => channel["id"] }
  #       end
  #     end
  #     return channel_list
  #   end
  
end

# def list_channels
#   url = "https://slack.com/api/channels.list?token=#{SLACK_TOKEN}&pretty=1"
#   response = HTTParty.get(url)

#   channel_list = []
#   response['channels'].each do |channel|
#     channel_list << channel
#   end

#   return channel_list
# end

# def self.load_all
#   all_channels = []

#   url = "https://slack.com/api/channels.list?token=#{SLACK_TOKEN}&pretty=1"
#   response = HTTParty.get(url)

#   response["channels"].each do |channel|
#     id = channel["id"]
#     name = channel["name"]
#     topic = channel["topic"]["value"]
#     member_count = channel["num_members"]

#     slack_channel = Channel.new(id, name, topic, member_count)

#     all_channels << slack_channel
#   end

#   return all_channels
# end