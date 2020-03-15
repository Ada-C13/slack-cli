require_relative "test_helper"
require_relative "../lib/channel"

describe "Channel" do
  before do
    @topic = "topic"
    @num_members = 3
    @slack_id = "RN123"
    @name = 'name'
    @channel = Channel.new(topic: @topic, num_members: @num_members, slack_id: @slack_id, name: @name) 
  end

  describe "constructor" do
    it "instance of channel class" do
      expect (@channel).must_be_instance_of Channel
    end
    it "can access attributes"do
      expect(@topic).must_equal @topic
      expect(@num_members).must_equal @num_members
      expect(@slack_id).must_equal @slack_id
    end
  end

  describe "self.get" do
    it "gets list of channels" do
      result = {}
      VCR.use_cassette("channels-list-endpoint") do
        result = Channel.get("https://slack.com/api/channels.list")
      end
      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error if call fails" do
      VCR.use_cassette("channels-list-endpoint") do
        expect {Channel.get("https://slack.com/api/bogus.endpoint")}.must_raise SlackAPIError
      end
    end
  end

  describe "self.list_all" do
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