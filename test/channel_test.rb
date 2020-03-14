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
end

describe "#details" do
  it "returns details about a Channel" do
    details = "\nThe channel with name Random and Slack ID CV5H594KE is described as 'Non-work banter and water cooler conversation'.\nThere are 8 members in this channel.\n"
    selected = nil
    VCR.use_cassette("channels.list") do
      workspace = SlackCLI::Workspace.new
      selected = workspace.select_channel('random')  
    end

    expect(selected).must_be_instance_of SlackCLI::Channel
    expect(selected.details).must_equal details
  end
end