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

describe "#select_user" do
	
	before do
		VCR.use_cassette("workspace_create") do
			@workspace = SlackCLI::Workspace.new
		end
	end

	it "returns a user based on Slack ID" do
		searching = "UV6A4F83S"
		@workspace.select_user(searching)
		expect(@workspace.selected).must_be_instance_of SlackCLI::User
		expect(@workspace.selected.name).must_equal "jessicursliang"
	end

	it "returns a user based on username" do
		searching = "jessicursliang"
		@workspace.select_user(searching)
		expect(@workspace.selected).must_be_instance_of SlackCLI::User
		expect(@workspace.selected.slack_id).must_equal "UV6A4F83S"
	end

	it "returns a user based on Slack ID wrong case" do
		searching = "uv6a4f83s"
		@workspace.select_user(searching)
		expect(@workspace.selected).must_be_instance_of SlackCLI::User
		expect(@workspace.selected.name).must_equal "jessicursliang"
	end

	it "returns a user based on username wrong case" do
		searching = "JESSICURSLIANG"
		@workspace.select_user(searching)
		expect(@workspace.selected).must_be_instance_of SlackCLI::User
		expect(@workspace.selected.slack_id).must_equal "UV6A4F83S"
	end

	it "does not select anything if nothing is found for searched username" do
		searching_name = "butthead"
		expect(@workspace.select_user(searching_name)).must_be_nil
	end

	it "does not select anything if nothing is found for searched id" do
		searching_id = "UV6AFFF76"
		expect(@workspace.select_user(searching_id)).must_be_nil
	end

end

describe "#select_channel" do
	
	before do
		VCR.use_cassette("workspace_create") do
			@workspace = SlackCLI::Workspace.new
		end
	end

	it "returns a channel based on Slack ID" do
		searching = "CV8FWUH8W"
		@workspace.select_channel(searching)
		expect(@workspace.selected).must_be_instance_of SlackCLI::Channel
		expect(@workspace.selected.name).must_equal "general"
	end

	it "returns a user based on channel name" do
		searching = "general"
		@workspace.select_channel(searching)
		expect(@workspace.selected).must_be_instance_of SlackCLI::Channel
		expect(@workspace.selected.slack_id).must_equal "CV8FWUH8W"
	end

	it "returns a channel based on Slack ID wrong case" do
		searching = "cv8fwuh8w"
		@workspace.select_channel(searching)
		expect(@workspace.selected).must_be_instance_of SlackCLI::Channel
		expect(@workspace.selected.name).must_equal "general"
	end

	it "returns a user based on channel name wrong case" do
		searching = "GENERAL"
		@workspace.select_channel(searching)
		expect(@workspace.selected).must_be_instance_of SlackCLI::Channel
		expect(@workspace.selected.slack_id).must_equal "CV8FWUH8W"
	end

	it "does not select anything if nothing is found for searched channel name" do
		searching_name = "butthead222"
		expect(@workspace.select_channel(searching_name)).must_be_nil
	end

	it "does not select anything if nothing is found for searched channel id" do
		searching_id = "CV6AFFF76"
		expect(@workspace.select_channel(searching_id)).must_be_nil
	end
	
end

describe "#show_details" do
	
	before do
		VCR.use_cassette("workspace_create") do
			@workspace = SlackCLI::Workspace.new
		end
	end

	it "returns a USER" do
		@workspace.select_user("jessicursliang")
		expect(@workspace.show_details).must_be_instance_of SlackCLI::User
		expect(@workspace.selected).must_be_instance_of SlackCLI::User
	end

	it "returns a CHANNEL" do
		@workspace.select_channel("general")
		expect(@workspace.show_details).must_be_instance_of SlackCLI::Channel
		expect(@workspace.selected).must_be_instance_of SlackCLI::Channel
	end

	it "does not show details if nothing is selected" do
		expect(@workspace.show_details).must_be_nil
	end
end

describe "#send_message" do
	before do
		VCR.use_cassette("workspace_create") do
			@workspace = SlackCLI::Workspace.new
		end
	end

	it "recieves a 200 OK if something is selected" do
		VCR.use_cassette("recipient_create") do
			space = SlackCLI::Workspace.new
			message = "hello world"
			space.select_channel("butthead")
			expect(space.send_message(message)).must_equal true
		end
	end


end