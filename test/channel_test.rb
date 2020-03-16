require_relative "test_helper"

describe "Channel class" do
  describe 'Channel instantiation' do
    it "creates a channel object" do
      VCR.use_cassette("list-channel-endpoint") do
        
        url = "https://slack.com/api/channels.list"
        response = Channel.get(url)
        
        channels = []
        response["channels"].each do |item|
          topic = item["topic"]
          member_count = item["members"]
          slack_id = item["id"]
          name = item["name"]
    
          channels << Channel.new(topic: topic, member_count: member_count, slack_id: slack_id, slack_id: slack_id, name: name)
        end

        expect(channels[0]).must_be_instance_of Channel
        
        expected_topic = {"value" => "", "creator" => "", "last_set" => 0}
        expect(channels[0].topic).must_equal expected_topic
        expect(channels[0].member_count.length).must_equal 5
        expect(channels[0].slack_id).must_equal "CV5KNMDKN"
        expect(channels[0].name).must_equal "slack-cli"
      end
    end
  end

  describe "self.get" do
    it "can get a list of channels" do
      result = {}
      VCR.use_cassette("list-channel-endpoint") do
        result = Channel.get("https://slack.com/api/channels.list")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error when a call fails" do
      VCR.use_cassette("list-channel-endpoint") do
        expect {Channel.get("https://slack.com/api/bogus.call")}.must_raise SlackAPIError
      end
    end
  end

  describe "self.list_all" do
    it "returns a list of valid channels" do
      result = []
      VCR.use_cassette("list-channel-endpoint") do
        result = Channel.list_all
      end

      expect(result).must_be_kind_of Array
      expect(result.length).must_be :>, 0
      result.each do |item|
        expect(item).must_be_kind_of Channel
      end
    end
  end
end