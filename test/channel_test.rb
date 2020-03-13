require_relative 'test_helper'

describe "Channel class" do
	before do
		@channel = SlackCLI::Channel.new(
			slack_id: "CUT6YR3LJ", 
			name: "lees-test-channel",
			topic: "For having fun with the Slack API!!",
			member_count: 2
		)
	end

	describe "Channel instantiation" do
		it "is an instance of Channel" do
			expect(@channel).must_be_kind_of SlackCLI::Channel
		end

		it "is set up for specific attributes and data types" do
      [:slack_id, :name, :topic, :member_count].each do |attribute|
        expect(@channel).must_respond_to attribute
      end

      expect(@channel.slack_id).must_be_kind_of String
			expect(@channel.name).must_be_kind_of String
			expect(@channel.topic).must_be_kind_of String
			expect(@channel.member_count).must_be_kind_of Integer
		end
	end

	describe "#self.list_all" do
		it "returns all the channels" do
			VCR.use_cassette("slack-channels") do
				channels = SlackCLI::Channel.list_all
				expect(channels).must_be_kind_of Array
				expect(channels.length).must_equal 6
			end
		end

		it "returns the correct information for the first channel" do
			VCR.use_cassette("slack-channels") do
				channels = SlackCLI::Channel.list_all
				expect(channels[0].slack_id).must_equal "CUT6YR3LJ"
				expect(channels[0].name).must_equal "lees-test-channel"
				expect(channels[0].topic).must_equal "For having fun with the Slack API!!"
				expect(channels[0].member_count).must_equal 2
			end
		end

		it "returns the correct information for the last channel" do
			VCR.use_cassette("slack-channels") do
				channels = SlackCLI::Channel.list_all
				expect(channels[-1].slack_id).must_equal "CVB8WV8BS"
				expect(channels[-1].name).must_equal "fun"
				expect(channels[-1].topic).must_equal ""
				expect(channels[-1].member_count).must_equal 5
			end
		end
	end
end