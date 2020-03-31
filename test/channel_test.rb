require_relative "test_helper"
require_relative "../lib/channel"

describe "Channel" do
  describe 'User instantiation' do
    it "creates a user object" do
      VCR.use_cassette("list-user-endpoint") do
        url = "https://slack.com/api/channels.list"
        response = Channel.get(url)
        channels = []
        response["channels"].each do |channel|
          topic = channel["topic"]
          member_count = channel["num_members"]
          name = channel["name"]
          slack_id = channel["id"]
          channels << Channel.new(topic: topic, member_count: member_count, name: name, slack_id:slack_id)
        end
        expect(channels[1]).must_be_instance_of Channel
        expect(channels[1].topic).must_be_kind_of Hash
        expect(channels[1].member_count).must_equal 5
        expect(channels[1].name).must_equal "general"
        expect(channels[1].slack_id).must_equal "CV5KRSHJQ"
      end
    end
  end
  describe "self.get" do
    it "can get a list of users" do
      result = {}
      VCR.use_cassette("list-user-endpoint") do
        result = Channel.get("https://slack.com/api/channels.list")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error when a call fails" do
      VCR.use_cassette("list-user-endpoint") do
        expect {Channel.get("https://slack.com/api/lak.call")}.must_raise SlackAPIError
      end
    end
  end

  describe "self.list_all" do
    it "returns a list of valid users" do
      result = []
      VCR.use_cassette("list-user-endpoint") do
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