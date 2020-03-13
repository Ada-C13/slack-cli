# channel_test.rb
require_relative 'test_helper'

describe "Channel" do

  before do
    @channel = Slack_cli::Channel.new(
      id: 54,
      name: "Test Channel",
      topic: "Test Topic",
      member_count: 5
    )
  end

  it "is an instance of Channel" do
    expect(@channel).must_be_kind_of Slack_cli::Channel
  end


  it "can get the list of channels" do
    VCR.use_cassette("channel-channels") do

      base_url = "https://slack.com/api/"
      post_url = "#{base_url}channels.list"
      params = { token: ENV["SLACK_API_TOKEN"] }

      response = Slack_cli::Channel.get(post_url, params)

      count = response["channels"].select do |channel|
        channel["name"]
      end
      
      channels = Slack_cli::Channel.list_all
      general = channels[0].name

      expect(channels).must_be_kind_of Array
      expect(channels.length).must_equal count.length
      expect(general).must_equal count[0]["name"]
    end
  end
end