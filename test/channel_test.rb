require_relative 'test_helper'

describe 'instantiates a channel' do
  
  it 'channel object properties' do
    new_channel = Channel.new('CUTE4M96W', "general", "a place for general communications", 6)
    
    expect(new_channel).must_be_instance_of Channel
    expect(new_channel.slack_id).must_equal 'CUTE4M96W'
    expect(new_channel.name).must_equal "general"
    expect(new_channel.topic).must_equal "a place for general communications"
    expect(new_channel.member_count).must_equal 6
  end
  
end