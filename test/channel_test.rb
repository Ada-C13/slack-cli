# channel_test.rb
require_relative 'test_helper'
require_relative "../lib/channel"

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
    response = []

    VCR.use_cassette("channels-list-endpoint") do
      response = Slack_cli::Channel.list_all
    end

    expect(response).must_be_kind_of Array
    expect(response.length).must_be :>, 0

    response.each do |resp|
      expect(resp).must_be_kind_of Slack_cli::Channel
    end

  end
end