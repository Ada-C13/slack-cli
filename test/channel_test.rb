require_relative 'test_helper'
require_relative '../lib/channel'

describe 'Channel' do
  describe 'self.get' do
    it 'can get a list of channels' do
      result = {}
      VCR.use_cassette('channel-list-endpoint') do
        result = Channel.get("https://slack.com/api/conversations.list")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    describe 'details' do
      before do
        @channel = Channel.new(slack_id: "C0101BT4820", name: "general", topic: "Company-wide announcements and work-based matters", member_count: 4)
      end
      it "returns user details" do
      expect(@channel.details).must_equal "Slack ID: #{@channel.slack_id}, Name: #{@channel.name}, Topic: #{@channel.topic}, Member Count: #{@channel.member_count}"
    end
  end

    it 'raises an error when a call fails' do
      VCR.use_cassette('channel-list-endpoint') do
        expect {Channel.get('https://slack.com/api/bogus.call')}.must_raise SlackAPIError
      end
    end
  end

  describe 'self.list_all' do
    it 'returns a list of valid channels' do
      result = []
      VCR.use_cassette('channel-list-endpoint') do
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