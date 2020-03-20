require_relative 'test_helper'
require 'httparty'
require 'dotenv'

Dotenv.load

describe "Channel Class" do

  describe "Channel instantiation" do
    before do
      @channel = SlackCli::Channel.new(slack_id: 1 ,name: "hala", topic: "ada", member_count: 2342)
      @channel2 = SlackCli::Channel.new(slack_id: "CVDP09BL7" ,name: "halatests", topic: "ada", member_count: 1)
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
          SLACK_BOT_TOKEN = ENV["SLACK_BOT_TOKEN"]
          channels = HTTParty.get(CHANNELS_URL,	query: {token: SLACK_BOT_TOKEN })
    
          expect(SlackCli::Channel.list_all.length).must_equal 5
        end
    end

    it "can send a message to a channel"do
        VCR.use_cassette("send messages to channel") do
            expect(@channel2.send_message("testing new token!")).must_equal true && 200
            expect(@channel2.send_message("if you can see this")).must_equal true &&  200
            expect(@channel2.send_message("it means my token is working")).must_equal true && 200
            expect(@channel2.send_message("hi five!")).must_equal true &&  200
        end
    end


  end
end
