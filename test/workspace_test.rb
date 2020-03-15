require_relative 'test_helper'

describe "Workspace class" do
	before do
		VCR.use_cassette("users-list-endpoint") do
			VCR.use_cassette("channels-list-endpoint") do
				@workspace = SlackCLI::Workspace.new
			end
		end
	end

	describe "Workspace instantiation" do
		it "is an instance of Workspace" do
			expect(@workspace).must_be_kind_of SlackCLI::Workspace
		end

		it "is set up for specific attributes and data types" do
      [:users, :channels, :selected].each do |attribute|
        expect(@workspace).must_respond_to attribute
      end

      expect(@workspace.users).must_be_kind_of Array
			expect(@workspace.channels).must_be_kind_of Array
			expect(@workspace.selected).must_be_nil
		end
	end

	describe "#select_channel" do
		it "sets @selected to the selected channel" do
			@workspace.select_channel("CUT6YR3LJ")
			
			expect(@workspace.selected).must_be_kind_of SlackCLI::Channel
			expect(@workspace.selected.slack_id).must_equal "CUT6YR3LJ"
		end

		it "throws an exception if no channel has the given id" do
			expect{@workspace.select_channel("BOGUS_ID")}.must_raise SlackAPIError
		end
	end

	describe "#select_user" do
		it "sets @selected to the selected user" do
			@workspace.select_user("USLACKBOT")
			
			expect(@workspace.selected).must_be_kind_of SlackCLI::User
			expect(@workspace.selected.slack_id).must_equal "USLACKBOT"
		end

		it "throws an exception if no user has the given id" do
			expect{@workspace.select_user("BOGUS_ID")}.must_raise SlackAPIError
		end
	end
end