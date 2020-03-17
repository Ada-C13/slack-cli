require_relative 'test_helper'
require 'httparty'
require 'dotenv'

Dotenv.load

describe "Channel Class" do

  describe "Channel instantiation" do
    before do
      @channel = SlackCli::Channel.new(slack_id: 1 ,name: "hala", topic: "ada", member_count: 2342)
      @channel2 = SlackCli::Channel.new(slack_id: "C01067YP1T9" ,name: "halatests", topic: "ada", member_count: 1)
    end

    it "is an instance of Channel" do
      expect(@channel).must_be_kind_of SlackCli::Channel
    end

    it "must list details of the channel" do
        expect(@channel.details).must_equal [{"slack_id" => 1,"name" => "hala","topic" => "ada", "member_count" => 2342 }]
    end
    
    it "can list all channels in the workspace" do
        VCR.use_cassette("list all") do
          CHANNELS_URL = "https://slack.com/api/conversations.list" 
          SLACK_API_TOKEN = ENV["SLACK_API_TOKEN"]
          channels = HTTParty.get(CHANNELS_URL,	query: {token: SLACK_API_TOKEN })
    
          expect(SlackCli::Channel.list_all.length).must_equal 5
        end
    end

    it "can create a new channel"do
        VCR.use_cassette("send messages to channel") do
        expect(SlackCli::Channel.create_a_channel("hala_tests")).must_equal 200 
        end
    end

    it "can send a message to a channel"do
        VCR.use_cassette("send messages to channel") do
            expect(@channel2.send_message("hello!")).must_equal true && 200
            expect(@channel2.send_message("final test")).must_equal true && 200
        end
    end

  end
end
