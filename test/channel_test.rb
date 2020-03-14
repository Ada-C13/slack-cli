require_relative "test_helper"
require_relative "../lib/channel"

describe "Channel" do
  describe "self.get" do
    it "gets a list of channels" do
      result = {}
      VCR.use_cassette("list-channel-endpoint") do
        result = Slack::Channel.get("https://slack.com/api/conversations.list")
      end
      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end
    it "raises error when call fails" do
      VCR.use_cassette("list-channel-endpoint") do
        expect { Slack::Channel.get("https://slack.com/api/bogus.call") }.must_raise SlackAPIError
      end
    end
  end
end
