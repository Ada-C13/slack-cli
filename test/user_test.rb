require_relative 'test_helper'

describe "initialize" do

	before do
		VCR.use_cassette("user_create") do
			@response = SlackCLI::Recipient.get_response("users.list")
		end

		@new_user = SlackCLI::User.new(@response["members"][0]["name"], @response["members"][0]["profile"]["real_name"], @response["members"][0]["id"])
		@new_user_two = SlackCLI::User.new(@response["members"][2]["name"], @response["members"][2]["profile"]["real_name"], @response["members"][2]["id"])
	end

	it "creates an instance of Channel" do
		expect(@new_user).must_be_instance_of SlackCLI::User
	end

	it "creates Channel with correctly set instance variables" do
		expect(@new_user.username).must_equal "slackbot"
		expect(@new_user.real_name).must_equal "Slackbot"
		expect(@new_user.slack_id).must_equal "USLACKBOT"
	end

	it "creates Channel with correctly set instance variables again" do
		expect(@new_user_two.username).must_equal "corinna.fabre"
		expect(@new_user_two.real_name).must_equal "Corinna Fabre"
		expect(@new_user_two.slack_id).must_equal "UUUSFT2AX"
	end
end