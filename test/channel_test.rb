require_relative "test_helper"
require_relative "../lib/channel"

describe "channel" do
  before do 
    channel_data = {
      "id" => "CUT7CLL1Y",
      "name" => "general",
      "is_channel" => true,
      "is_group" => false,
      "is_im" => false,
      "created" => 1583866138,
      "is_archived" => false,
      "is_general" => true,
      "unlinked" => 0,
      "name_normalized" => "general",
      "is_shared" => false,
      "creator" => "UV614256C",
      "is_ext_shared" => false,
      "is_org_shared" => false,
      "shared_team_ids" => [
          "TV5H57Z7E"
      ],
      "pending_shared" => [],
      "pending_connected_team_ids" => [],
      "is_pending_ext_shared" => false,
      "is_member" => false,
      "is_private" => false,
      "is_mpim" => false,
      "topic" => {
          "value" => "Company-wide announcements and work-based matters",
          "creator" => "UV614256C",
          "last_set" => 1583866138
      },
      "purpose" => {
          "value" => "This channel is for workspace-wide communication and announcements. All members are in this channel.",
          "creator" => "UV614256C",
          "last_set" => 1583866138
      },
      "previous_names" => [],
      "num_members" => 9
  }
    @channel = Slack::Channel.new(channel_data)
  end

  describe "initialize" do
    it "raises an exception when trying to create a User with bad parameters" do
      expect{(Slack::Channel.new({"id"=>"USLACKBOT", "team_id"=>"TV5H57Z7E", "name"=>"slackbot"}))}.must_raise ArgumentError
    end

    it "creates a new Channel instance" do
      expect(@channel).must_be_kind_of Slack::Channel
    end

    it "saves id to the Channel instance" do
      expect(@channel.id).must_equal "CUT7CLL1Y"
    end

    it "saves name to the Channel instance" do
      expect(@channel.name).must_equal "general"
    end

    it "saves topic to the Channel instance" do
      expect(@channel.topic).must_equal "Company-wide announcements and work-based matters"
    end
    
    it "has an accurate count of members" do
      expect(@channel.member_count).must_equal 9
    end
  end

  describe "get_all" do
    # returns a non-empty array of channels 
    it "returns an array of channel data" do
      VCR.use_cassette("conversations_list_endpoint") do
        data = Slack::Channel.get_all
        expect(data).must_be_kind_of Array
        expect(data.length > 0).must_equal true    
      end
    end
  end

  describe "list_all" do
    # one of the channels must be the General channel
    it "returns an array of Channel objects" do
      VCR.use_cassette("conversations_list_endpoint") do
        results = Slack::Channel.list_all
        expect(results).must_be_kind_of Array
        expect(results.all? { |result| result.class == Slack::Channel } ).must_equal true  
      end
    end

    it "has a General channel" do
      VCR.use_cassette("conversations_list_endpoint") do
        results = Slack::Channel.list_all
        expect(results.any? { |result| result.name == "general" } ).must_equal true  
      end
    end
  end
  
end