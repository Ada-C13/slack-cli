require_relative 'test_helper'

describe 'initialize' do
  
  it 'channel object properties' do
    new_channel = Channel.new('CUTE4M96W', "random", "a place for general communications", 6)
    
    expect(new_channel).must_be_instance_of Channel
    expect(new_channel.slack_id).must_equal 'CUTE4M96W'
    expect(new_channel.name).must_equal "random"
    expect(new_channel.topic).must_equal "a place for general communications"
    expect(new_channel.member_count).must_equal 6
  end
  
end


describe "channel.get_everthing" do
  it 'loads channels' do
    VCR.use_cassette('load_channels') do 
      all_channels = Channel.get_everything("channels.list") 
      expect(all_channels).must_be_kind_of HTTParty::Response
      expect(all_channels["channels"].length).must_be :>, 0
    end 
  end
  
  it 'raises a Slack API Error if it receives an error code' do
    VCR.use_cassette('load_channels') do
      expect{ Channel.get_everything("bad.sub.url") }.must_raise SlackAPIError
    end
  end
end


describe 'channel.list_all' do
  
  it 'loads correct channel info' do
    VCR.use_cassette('load_channels') do 
      all_channels = Channel.list_channels 
      test_channel = all_channels[0]
      expect(test_channel.slack_id).must_equal "CUTE4M96W"
      expect(test_channel.name).must_equal "general"
      expect(test_channel.topic).must_equal "Company-wide announcements and work-based matters"
      expect(test_channel.member_count).must_equal 6
    end
  end
  
end


describe 'details' do
  before do 
    @channel = Channel.new('CUTE4M96W', "general", "a place for general communications", 6)
  end
  
  it "displays details of selected recipient" do
    expect(@channel.details).must_equal "Slack ID: CUTE4M96W, Name: general, Topic: a place for general communications, Member Count: 6"
  end
end