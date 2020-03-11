require_relative "test_helper"

describe "channel" do
  describe "self.list_all" do
    it "returns an array of Channel instances" do
      VCR.use_cassette("channels_list_endpoint") do
        all_channels = Channel.list_all
        expect(all_channels).must_be_instance_of Array
        all_channels.each do |channel|
          expect(channel).must_be_instance_of Channel
          expect(channel.slack_id).must_be_instance_of String
          expect(channel.name).must_be_instance_of String
          expect(channel.member_count).must_be_instance_of Integer
        end
      end
    end

    it "stores the members information in the User instance" do
      # name, topic, member count, and Slack ID
      VCR.use_cassette("channels_list_endpoint") do
        all_channels = Channel.list_all
        expect(all_channels[2].slack_id).must_equal "CV6AN643F"
        expect(all_channels[2].name).must_equal "random"
        expect(all_channels[2].member_count).must_equal 5
      end
    end
  end
end
