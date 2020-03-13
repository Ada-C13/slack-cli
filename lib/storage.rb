# def list_channels
#   url = "https://slack.com/api/channels.list?token=#{SLACK_TOKEN}&pretty=1"
#   response = HTTParty.get(url)
  
#   channel_list = []
#   response['channels'].each do |channel|
#     channel_list << channel["name"]
#   end
  
#   return channel_list
# end



# describe 'list channels' do
#   before do
#     @workspace = Workspace.new
#   end

#   it 'can find channels' do
#     VCR.use_cassette('list_channels') do
#       channels = @workspace.list_channels

#       expect(channels).must_be_kind_of Array
#       expect(channels.length).must_equal 3
#       expect(channels).must_equal ["general", "api-testing", "random"]
#     end
#   end

# end