# def list_channels
#   url = "https://slack.com/api/channels.list?token=#{SLACK_TOKEN}&pretty=1"
#   response = HTTParty.get(url)
  
#   channel_list = []
#   response['channels'].each do |channel|
#     channel_list << channel["name"]
#   end
  
#   return channel_list
# end