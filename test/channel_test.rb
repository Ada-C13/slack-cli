require_relative "test_helper"
require_relative "../lib/channel"

describe "Channel class" do
  let (:channel_data) {
    {
      slack_id: "CV8PR7M4M",
      name: "general",
      topic: "let's do group bonding exercise",
      member_count: 9,
    }
  }
  it "creates a channel" do
    channel = SlackCLI::Channel.new(
      channel_data[:slack_id],
      channel_data[:name],
      channel_data[:topic],
      channel_data[:member_count],
    )
    expect(channel).must_be_instance_of SlackCLI::Channel
  end
end

# to do: write channel test and do send message promte on slack.rb
