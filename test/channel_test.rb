require_relative "test_helper"

describe Channel do
  describe "self.list_all method" do
    it "return a valid list of the channels" do
      response = []
      VCR.use_cassette("list_of_channels") do
        response = Channel.list_all
      end

      expect(response).must_be_kind_of Array
      expect(response.length).must_be :>, 0 
      response.each do |channel|
        expect(channel).must_be_kind_of Channel
      end
    end

    it "must include slackbot in the user lists" do
      VCR.use_cassette("list_of_channels") do
        response = Channel.list_all
        expect(response[1].name).must_equal "general"
      end
    end
  end

  describe "self.get" do
    it "gets a list of users and returns than as an HTTParty response" do
      response = {}
      VCR.use_cassette("list_of_channels") do
        response = Channel.get("https://slack.com/api/conversations.list")
      end
      expect(response).must_be_kind_of HTTParty::Response
      expect(response["ok"]).must_equal true
    end

    it "raises an error when a call fails" do
      VCR.use_cassette("list_of_channels") do
        expect{Channel.get("https://slack.com/api/whatever")}.must_raise SlackAPIError
      end
    end
  end
end