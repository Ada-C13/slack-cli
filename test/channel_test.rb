require_relative 'test_helper'
require "./lib/channel"

describe "Channel" do
  describe "details" do
  end  

  describe "self.get" do
    it "gets a list of channels" do
      result = {}
      VCR.use_cassette("channels-list") do
        result = Channel.get("channels.list")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error when the call fails" do
      VCR.use_cassette("channels-list-fail") do
        expect{Channel.get("channelsfail.list")}.must_raise SlackApiError
      end
    end
  end

  describe "self.list_all" do
    it "returns a list all channels" do
      VCR.use_cassette("channel-details") do
        response = Channel.list_all
        response.each do |channel|
          expect(channel).must_be_kind_of Channel
          expect(channel).must_respond_to :slack_id
        end
      end
    end  
  end
end
