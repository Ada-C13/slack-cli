require_relative "test_helper"

describe "Channel" do
  
  describe "Initialize" do

    before do
      @channel = SlackCLI::Channel.new("poop", "poop", 4, "BUTHFRBNW")
    end

    it "can create an instance of Channel" do
      VCR.use_cassette("channel_class") do
        expect(@channel).must_be_kind_of SlackCLI::Channel
        expect(@channel.name).must_equal "poop"
        expect(@channel.topic).must_equal "poop"
        expect(@channel.member_count).must_equal 4
      end
    end

    it "can load all channels in Channel" do
      VCR.use_cassette("channel_class") do
        expect(SlackCLI::Channel.load_all.length).must_equal 5
      end
    end
  end
end