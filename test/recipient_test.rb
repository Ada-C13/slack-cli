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