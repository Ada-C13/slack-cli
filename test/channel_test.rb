require_relative "test_helper"
require_relative '../lib/channel'

describe "#initialize" do
  it "returns a specific instance of a Channel" do
    channel = nil
    VCR.use_cassette("channels.list") do
      data = {'id' => '1234',
        'name' => 'bot',
        'topic' => {'value' => 'test text'},
        'num_members' => '100'}
  
      channel = SlackCLI::Channel.new(data)
    end
    expect(channel).must_be_instance_of SlackCLI::Channel
    expect(channel.slack_id).must_equal '1234'
    expect(channel.name).must_equal 'bot'
    expect(channel.topic).must_equal 'test text'
    expect(channel.member_count).must_equal '100'
  end
end

describe ".list_all" do
  it "provides instances of Channel class" do
    channels = []
    VCR.use_cassette("channels.list") do
      channels = SlackCLI::Channel.list_all
    end
    
    expect(channels.first).must_be_instance_of SlackCLI::Channel
    expect(channels.last).must_be_instance_of SlackCLI::Channel
  end
end

describe "#details" do
  it "returns details about a Channel" do
    details = "\nThe channel with name Random and Slack ID CV5H594KE is described as 'Non-work banter and water cooler conversation'. There are 8 members in this channel."
    selected = nil
    VCR.use_cassette("channels.list") do
      workspace = SlackCLI::Workspace.new
      selected = workspace.select_channel('random')  
    end

    expect(selected).must_be_instance_of SlackCLI::Channel
    expect(selected.details).must_equal details
  end
end