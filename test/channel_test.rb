require_relative 'test_helper'

describe "Channel class" do
  
  before do
    VCR.use_cassette("chanel_response") do
      @url = "https://slack.com/api/channels.list"
      @response = Channel.get(@url)
    end
  end
  describe "channel object initialize" do
    it "creates a channel object" do
      
      new_channel_array = []
      @response["channels"].each do |channel|
        topic = channel["topic"]["value"]
        member_count = channel["num_members"]
        slack_id = channel["id"]
        name = channel["name"]
        new_channel_array << new_channel = Channel.new(topic: topic, member_count: member_count, slack_id: slack_id, name: name)
      end
      
      expect(new_channel_array[0]).must_be_instance_of Channel
      expect(new_channel_array[0].name).must_equal "general"
      expect(new_channel_array[0].topic).must_equal "Company-wide announcements and work-based matters"
      expect(new_channel_array[0].member_count).must_equal 5
      
    end

  end

  describe "self.list_all" do
    it "lists all the channels' names, topics, member count, and slack id " do
      VCR.use_cassette("list all channels") do
        all_channels = Channel.list_all

        expect(all_channels.count).must_equal 3
        expect(all_channels[1].slack_id).must_equal "CUTE4MTD0"
        expect(all_channels[1].name).must_equal "api-testing"
        expect(all_channels[1].member_count).must_equal 5
        
      end
    end

    it "raises SlackApiError" do
      VCR.use_cassette("list all channels") do
        url = "https://slack.com/api/channels.lissdf"
        expect{Channel.get(url)}.must_raise SlackApiError
      end
    end
  end
end