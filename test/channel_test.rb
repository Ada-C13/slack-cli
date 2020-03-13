require_relative "test_helper"
# Any tests involving a Channel should use the #random channel

describe 'Channel class' do
  describe "self.list_all" do
    it 'should list all channels' do
      VCR.use_cassette("channels") do
        response = Recipient.get("https://slack.com/api/channels.list")
        all_channels = Channel.list_all
        expect(response.code).must_equal 200
        expect(all_channels[2].name).must_equal "random"
        expect(all_channels[2].slack_id).must_equal "CV86RT7AS"
        expect(all_channels[2].member_count).must_equal 5
        expect(all_channels[2].topic).must_equal "Non-work banter and water cooler conversation"
      end
    end
  end

  describe "details" do
    it 'should get the details of a specified channel' do
      VCR.use_cassette("channels") do
        response = Recipient.get("https://slack.com/api/channels.list")
        random = Channel.new(slack_id: "CV86RT7AS", name: "random", member_count: "5", topic: "Non-work banter and water cooler conversation")
        expect(response.code).must_equal 200
        expect(random.details).must_include random.name
        expect(random.details).must_include random.member_count
        expect(random.details).must_include random.topic
      end
    end
  end
end