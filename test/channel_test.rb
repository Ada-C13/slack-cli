#coded along with Devin for Wave 1

require_relative "test_helper"
require_relative '../lib/channel'

describe "Channel" do

  describe "Channel.new" do
    it "creates a new channel" do
      new_channel = Channel.new(slack_id: 1, name: "name", topic: "topic", member_count: "member_count")

      expect(new_channel.name).must_equal "name"
      expect(new_channel.slack_id).must_equal 1
      expect(new_channel).must_be_kind_of Channel
    end
  end
  
  describe "self.get" do
    it "gets a list of channels" do
      result = {}
      VCR.use_cassette("channel-list-endpoint") do
        result = Channel.get("https://slack.com/api/conversations.list")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true   
    end

    it "raises an error when a call fails" do
      VCR.use_cassette("channel-list-endpoint") do
        expect {User.get("https://slack.com/api/bogus.endpoint")}.must_raise SlackAPIError
      end
    end
  end

  describe "self.list" do
    it "returns a valid list of channels" do
      result = []

      VCR.use_cassette("channel-list-endpoint") do
        result = Channel.list_all
      end

      expect(result).must_be_kind_of Array
      expect(result.length).must_be :>, 0
      result.each do |channel|
        expect(channel).must_be_kind_of Channel
      end
    end
  end
  
end