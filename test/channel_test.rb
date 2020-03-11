require_relative 'test_helper'

describe "initialize" do

	before do
		VCR.use_cassette("channel_create") do
			@response = SlackCLI::Recipient.get_response("channels.list")
		end

		name = @response["channels"][0]["name"]
		topic = @response["channels"][0]["topic"]["value"]
		member_count = @response["channels"][0]["members"].length
		slack_id = @response["channels"][0]["id"]

		@new_ch = SlackCLI::Channel.new(name, topic, member_count, slack_id)
	end

	it "creates an instance of Channel" do
		expect(@new_ch).must_be_instance_of SlackCLI::Channel
	end

	it "creates Channel with correctly set instance variables" do
		expect(@new_ch.name).must_equal "slackcli"
		expect(@new_ch.topic).must_equal ""
		expect(@new_ch.member_count).must_equal 4
		expect(@new_ch.slack_id).must_equal "CUURD2M5Z"
	end

end