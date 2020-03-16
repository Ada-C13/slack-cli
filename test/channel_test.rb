require_relative "test_helper"
require_relative "../lib/channel"

describe "Channel class" do
  describe "initialize" do
    before do
      @chan_inst = Channel.new(
        name: "stuff",
        slack_id: "THISISANID",
        topic: "This is a channel to talk about stuff.",
        member_count: "3"
      )
    end
    it "is an instance of Channel" do
      expect(@chan_inst).must_be_kind_of Channel
    end
  end

  describe "list_all" do
    it "creates an array of channels" do
      VCR.use_cassette("list_channels_endpoint") do
        channels = Channel.list_all

        expect(channels).wont_be :empty?
        expect(channels).must_be_kind_of Array
        expect(channels[0]).must_be_kind_of Channel
      end
    end

    describe "self.get" do
      it "gets a list of channels from the api" do
        list = {}
        VCR.use_cassette("list_channels_endpoint") do
          list = Channel.get("https://slack.com/api/conversations.list")
        end
        
        expect(list).must_be_kind_of HTTParty::Response
        expect(list["ok"]).must_equal true
      end

      it "raises an error when the api call fails" do
        VCR.use_cassette("list_channels_endpoint") do
          expect {Channel.get("https://slack.com/api/bogus.call")}.must_raise SlackAPIError
        end
      end
    end
  end
end
