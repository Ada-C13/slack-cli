require_relative "test_helper"
require_relative "../lib/channel"

describe "Channel class" do
  describe 'Channel instantiation' do
    before do
      @channel = Channel.new(slack_id: "CV5KNMDKN", name: "slack-cli")
    end
    
    it "is an instance of Channel" do
      expect(@channel).must_be_kind_of Channel
    end

    it "is set up for specific attributes and data     types" do
      [:topic, :member_count, :slack_id, :name].each do |prop|
        expect(@channel).must_respond_to prop
      end
      
      expect(@channel.topic).must_be_kind_of Hash
      expect(@channel.name).must_be_kind_of String
      expect(@channel.member_count).must_be_kind_of Array
      expect(@channel.slack_id).must_be_kind_of String
    end
  end

  describe "self.get" do
    it "can get a list of channels" do
      result = {}
      VCR.use_cassette("list-chanel-endpoint") do
        result = Channel.get("https://slack.com/api/channels.list")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error when a call fails" do
      VCR.use_cassette("list-user-endpoint") do
        expect {User.get("https://slack.com/api/bogus.call")}.must_raise SlackAPIError
      end
    end
  end
end