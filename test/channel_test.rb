require_relative "test_helper"
require_relative "../lib/channel"

describe "Channel" do
  describe "self.get" do
    it "can get a list of users" do
      result = {}
      VCR.use_cassette("list-user-endpoint") do
        result = Channel.get("https://slack.com/api/channels.list")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error when a call fails" do
      VCR.use_cassette("list-user-endpoint") do
        expect {Channel.get("https://slack.com/api/lak.call")}.must_raise SlackAPIError
      end
    end
  end

  describe "self.list_all" do
    it "returns a list of valid users" do
      result = []
      VCR.use_cassette("list-user-endpoint") do
        result = Channel.list_all
      end

      expect(result).must_be_kind_of Array
      expect(result.length).must_be :>, 0
      result.each do |item|
        expect(item).must_be_kind_of Channel
      end

    end
  end
end