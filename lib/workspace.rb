class Workspace
  attr_reader :users, :channels
  
  def initialize
    @users = [] # will be array of users
    @channels = [] # will be array of channels
  end
  
  # this method will list all the channels!
  def token_test
    url = "https://slack.com/api/channels.list?token=#{SLACK_TOKEN}&pretty=1"
    response = HTTParty.get(url)
    
    channel_list = []
    # looking at "channels" in response
    # for each thing in channels (channel), look at the thing labelled "name", shove that into the array
    response['channels'].each do |channel|
      channel_list << channel["name"]
    end
    
    return channel_list
  end

end
