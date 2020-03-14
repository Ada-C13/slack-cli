require_relative 'test_helper'

describe "initalize" do

	before do
		VCR.use_cassette("recipient_create") do
			@response = SlackCLI::Recipient.get_response("users.list")
		end
	end
	
	it "returns a hash" do
		expect(@response).must_be_instance_of HTTParty::Response
	end

end

describe "self#send_message" do

	it "returns true if the request is valid" do
		VCR.use_cassette("recipient_create") do
			workspace = SlackCLI::Workspace.new
			workspace.select_channel("butthead")

			expect(SlackCLI::Recipient.send_message("hello world", workspace.selected)).must_equal true
		end
	end

	it "returns false if the request is invalid" do
		VCR.use_cassette("recipient_create") do
			workspace = SlackCLI::Workspace.new
			fake_ch = SlackCLI::Channel.new("butt", "butt topics", 3, "C12993CCC")
			expect{SlackCLI::Recipient.send_message("hello world", fake_ch)}.must_raise SlackCLI::SlackAPIError
		end
	end

end