require_relative 'test_helper'
require "./lib/channel"

describe "Channel" do
  describe "initialize" do
    it "creates a Channel object" do
      channel = Channel.new("slack-channel", "123456", "slack cli", 5)
      expect(channel).must_respond_to :slack_id
      expect(channel).must_respond_to :name
      expect(channel).must_respond_to :topic
      expect(channel).must_respond_to :member_count
    end
  end

  describe "details" do
    it "returns table of data" do
      channel = Channel.new("123456", "bobberts-channel", "bob's stuff", 1)
      expect(channel.details).must_be_kind_of TablePrint::Returnable
    end
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

  describe "send_message" do
    it "sends a message to the correct channel" do
      VCR.use_cassette("send-message") do
        channel = Channel.list_all[0]
        response = channel.send_message("the test message")
        expect(response).must_equal true
      end
    end

    it "raises SlackApiError if post request fails" do
      VCR.use_cassette("send-message") do
        channel = Channel.new("bogus", "bogus_info", "bogus", 5)
        expect{channel.send_message("the test message")}.must_raise SlackApiError
      end
    end
  end
end
