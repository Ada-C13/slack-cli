require_relative 'test_helper'
require_relative '../lib/channel'

describe "Channel" do
  describe "self.get" do
    it "gets a list of channels and returns them as an HTTParty Response" do
      result = {}
      VCR.use_cassette("channel-list-endpoint") do
        result = Channel.get("https://slack.com/api/channels.list")
      end
        expect(result).must_be_kind_of HTTParty::Response
        expect(result["ok"]).must_equal true
      end

    it "raises an error when a call fails" do
      VCR.use_cassette("channel-list-endpoint") do
        expect {Channel.get("https://slack.com/api/bogus.endpoint")}.must_raise SlackAPIError
      end
    end
  end #initialize

  #FROM DEVIN
  describe "self.load_all" do
    it "return a valid list of channels" do
      result = []
      VCR.use_cassette("channel-list-endpoint") do
        result = Channel.load_all
      end
    end
  end
end #class
