require_relative "test_helper"
require_relative '../lib/channel'

describe ".list_all" do
  it "provides instances of Channel class" do
    channels = []
    VCR.use_cassette("channels") do
      channels = SlackCLI::Channel.list_all
    end
    
    expect(channels.first).must_be_instance_of SlackCLI::Channel
    expect(channels.last).must_be_instance_of SlackCLI::Channel
  end

  it "raises an error if response fails" do
    VCR.use_cassette("channels") do
      expect{SlackCLI::Channel.list_all}.must_raise Exception
    end
  end
end