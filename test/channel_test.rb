require_relative "test_helper"
require_relative "../lib/channel"

describe "Channel" do
  describe "initialize" do 
    before do 
      VCR.use_cassette("channels-list-endpoint") do 
        @test_channel = Channel.new(topic: "talk about stuffs", member_count: 2, name: "meaningless-chatter", slack_id:"CHAT1234")
      end 
    end

    it "creates an instance of a Channel object with string & int keywords" do 
      expect(@test_channel).must_be_kind_of Channel
    end 
  end
  
  describe "self.get" do # inherited from recipient 
    it "gets a list of channels" do 
      result = {}
      VCR.use_cassette("channels-list-endpoint") do 
        result = Channel.get("https://slack.com/api/conversations.list")
      end 

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true # ensure its not a false positive response 
    end 

    it "raises an error when a call fails" do 
      VCR.use_cassette("channels-list-endpoint") do 
        expect{ Channel.get("https://slack.com/api/bogus.endpoint") }.must_raise SlackAPIError
      end 
    end 
  end 

  describe "self.list" do 
    it "returns a valid list of channels" do 
      result = []

      VCR.use_cassette("channels-list-endpoint") do 
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