require_relative 'test_helper'

describe "Channel" do
  
  describe "self.get" do
    it "gets a list of channels and returns them as a HTTParty response" do
      result = {}
      VCR.use_cassette("channels_list_endpoint") do
        result = Channel.get("https://slack.com/api/conversations.list",{
          token: ENV['SLACK_TOKEN'],
          pretty: 1
        })
      end
      expect(result).must_be_instance_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error when a call fails" do
      VCR.use_cassette("channels_list_endpoint") do
        expect {Channel.get("https://slack.com/api/bogus.endpoint",{ token: ENV['SLACK_TOKEN'] })}.must_raise SlackAPIError
      end
    end

    it "raises and error with invalid params" do
      VCR.use_cassette("channels_list_endpoint") do
        expect {Channel.get("https://slack.com/api/conversations.list", { token: "blah blah blah" })}.must_raise SlackAPIError
      end
    end
  end

  describe "self.list" do
    it "returns a valid list of channels" do
      result = []
      VCR.use_cassette("channels_list_endpoint") do
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