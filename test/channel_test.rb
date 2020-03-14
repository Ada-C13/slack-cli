require_relative 'test_helper'
require_relative '../lib/channel'


describe "channel" do
  CHANNELS_URI = "https://slack.com/api/conversations.list"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]

  describe "self.get" do
    it "receives response from the API call" do
      VCR.use_cassette("users_list_endpoint") do
        response = SlackCLI::Channel.get(CHANNELS_URI, {token: SLACK_TOKEN})
        expect(response).must_be_instance_of HTTParty::Response
        expect(response["ok"]).must_equal true
        expect(response["channels"]).wont_be_nil
        expect(response["channels"]).must_be_instance_of Array
        expect(response["channels"].length).wont_equal 0
      end
    end

    it "will raise an exception if the search fails" do
      VCR.use_cassette("users_list_endpoint") do
        #use the wrong keyword key instead of token
        expect{SlackCLI::Channel.get(CHANNELS_URI, {key: SLACK_TOKEN})}.must_raise SlackCLI::SlackAPIError
        expect{SlackCLI::Channel.get(CHANNELS_URI, {token: "XOXOSLACK"})}.must_raise SlackCLI::SlackAPIError
      end
    end
  end
  
  describe "self.list_all" do
    it "returns an array of Channel instances" do
      VCR.use_cassette("channels_list_endpoint") do
        all_channels = SlackCLI::Channel.list_all
        expect(all_channels).must_be_instance_of Array
        expect(all_channels.length).must_be :>, 0
        all_channels.each do |channel|
          expect(channel).must_be_instance_of SlackCLI::Channel
        end
      end
    end

    it "stores the members information in the User instance" do
      # name, topic, member count, and Slack ID
      VCR.use_cassette("channels_list_endpoint") do
        all_channels = SlackCLI::Channel.list_all
        all_channels.each do |channel|
          expect(channel.slack_id).must_be_instance_of String
          expect(channel.name).must_be_instance_of String
          expect(channel.member_count).must_be_instance_of Integer
        end
      end
    end
  end

  describe "#get_details" do
    it "can get all the details of the channel" do
      VCR.use_cassette("channels_list_endpoint") do
        all_channels = SlackCLI::Channel.list_all
        channel01 = all_channels[0]
        response = channel01.get_details
        expect(response).must_equal true
      end
    end
  end
end
