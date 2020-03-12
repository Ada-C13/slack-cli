require_relative 'test_helper'

describe 'instantiates a channel' do
  
  it 'channel object properties' do
    new_channel = Channel.new('CUTE4M96W', "random", "a place for general communications", 6)
    
    expect(new_channel).must_be_instance_of Channel
    expect(new_channel.slack_id).must_equal 'CUTE4M96W'
    expect(new_channel.name).must_equal "random"
    expect(new_channel.topic).must_equal "a place for general communications"
    expect(new_channel.member_count).must_equal 6
  end
  
end

describe 'it loads all the channels from slack api' do
  
  it 'loads channels' do
    VCR.use_cassette('load_channels') do 
      all_channels = Channel.list_channels
      expect(all_channels).must_be_kind_of Array
      expect(all_channels[0]).must_be_instance_of Channel
    end
  end
  
  it 'loads correct channel info' do
    VCR.use_cassette('load_channels') do 
      all_channels = Channel.list_channels
      test_channel = all_channels[0]
      expect(test_channel.slack_id).must_equal "CUTE4M96W"
      expect(test_channel.name).must_equal "general"
      expect(test_channel.topic).must_equal "Company-wide announcements and work-based matters"
      expect(test_channel.member_count).must_equal 4
    end
  end
  
end

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