require_relative 'test_helper'

describe "Channel" do
  describe ".list_all" do
    it "Can list channels" do
      VCR.use_cassette("list_channels") do
        channels = Channel.list_all

        expect(channels).wont_be_nil
        expect(channels.length > 0).must_equal true
      end
    end
  end

  describe "self.get" do
    it "gets a list of channels as a HTTP response object" do
      VCR.use_cassette("list_channels") do
        response = Channel.get("https://slack.com/api/channels.list")

        expect(response).must_be_kind_of HTTParty::Response 
        expect(response["ok"]).must_equal true 
        expect(response["channels"]).must_be_kind_of Array 
      end
    end

    it "raises an error when a call fails" do 
      VCR.use_cassette("list_channels") do
        expect{
          Channel.get("https://slack.com/api/channels.listik")
        }.must_raise SlackApiError
      end
    end
  end
end