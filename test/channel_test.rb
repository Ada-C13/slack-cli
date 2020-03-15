require_relative "test_helper"
require_relative "../lib/channel"

describe "Channel" do
  describe "initialize" do
    before do
      @channel = Channel.new("CUTE4M96W", "random", "random work-based matters", 5)
    end

    it "creates a new instance of Channel" do
      expect(@channel).must_be_kind_of Channel
      expect(@channel).must_respond_to :slack_id
      expect(@channel).must_respond_to :name
      expect(@channel).must_respond_to :topic
      expect(@channel).must_respond_to :member_count
    end

    it "stores an id" do
      expect(@channel.slack_id).must_equal "CUTE4M96W"
    end

    it "stores the channel's name" do
      expect(@channel.name).must_equal "random"
    end

    it "stores the channel's topic" do
      expect(@channel.topic).must_equal "random work-based matters"
    end

    it "stores the channel's member_count" do
      expect(@channel.member_count).must_equal 5
    end
  end

  describe "self.get_all" do
    it "gets a list of channels and returns them as an HTTParty Response" do
      result = {}
      VCR.use_cassette("channels-list-endpoint") do
        result = Channel.get_all("channels.list")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error when a call to users-list-endpoint fails" do
      VCR.use_cassette("channels-list-endpoint") do
        expect { Channel.get_all("bogussuburl") }.must_raise SlackAPIError
      end
    end
  end

  describe "list_channels" do
    it "returns an array of Channels" do
      VCR.use_cassette("workspace_initialize") do
        @workspace = Workspace.new
      end
      channels = @workspace.channels

      expect(channels).must_be_kind_of Array
      channels.each do |channel|
        expect(channel).must_be_kind_of Channel
      end
    end

    it "finds the expected channels" do
      VCR.use_cassette("workspace_initialize") do
        @workspace = Workspace.new
      end
      channels = @workspace.channels

      expect(channels).wont_be_nil
      expect(channels.length).must_be :>, 0
      expect(channels[0].name).must_equal "general"
      expect(channels[2].name).must_equal "random"
    end
  end
end