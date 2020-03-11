require_relative 'test_helper'

describe "initialize" do
	
	before do
		VCR.use_cassette("workspace_create") do
			@workspace = SlackCLI::Workspace.new
		end
	end

	it "creates an instance of Workspace" do
		expect(@workspace).must_be_instance_of SlackCLI::Workspace
		expect(@workspace.users).must_be_instance_of Array
		expect(@workspace.channels).must_be_instance_of Array
	end

end