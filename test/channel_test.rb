require_relative 'test_helper'

describe "Channel class" do
  describe "channel object initialize" do
    it "creates a channel object" do
      VCR.use_cassette("initialze channel object") do

        url = "https://slack.com/api/channels.list"
        response = Channel.get(url)

        new_channel = ""
        response["channels"].each do |channel|
          topic = channel["topic"]
          member_count = channel["num_members"]
          
          return new_channel = Channel.new(topic: topic, member_count: member_count)
        end
        
        expect(new_channel).must_be_instance_of Channel
        expect(new_channel.member_count).must_equal 5
        
      end
    end
  end

  describe "self.list_all" do
    it "lists all the channels' names, topics, member count, and slack id " do
      VCR.use_cassette("list all channels") do
        all_channels = Channel.list_all

        expect(all_channels.count).must_equal 3
        expect(all_channels[1]["Slack ID"]).must_equal "CUTE4MTD0"
        expect(all_channels[1]["Channel Name"]).must_equal "api-testing"
        expect(all_channels[1]["Member Count"]).must_equal 5
        
      end
    end
  end
end