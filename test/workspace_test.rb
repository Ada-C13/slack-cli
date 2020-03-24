require_relative "test_helper"
require_relative "../lib/workspace"

describe "workspace" do
  before do
    VCR.use_cassette("users_list_endpoint") do
      @test_workspace = Slack::Workspace.new
    end
  end

  describe "initialize" do

    it "creates a workspace object" do
        expect(@test_workspace).must_be_kind_of Slack::Workspace
    end

    it "initializes @selected to nil" do
      expect(@test_workspace.selected).must_equal nil 
    end

  end

  xdescribe "select_by_id" do
    it "raises an error when given invalid ID" do
      expect{(@test_workspace.select_by_id("bogus_user_id", :USER))}.must_raise ArgumentError
      expect{(@test_workspace.select_by_id("bogus_channel_id", :CHANNEL))}.must_raise ArgumentError
    end

    it "sets @selected to the specified object" do
      @test_workspace.select_by_id(SLACKBOT ID HERE, :USER)
      expect(@test_workspace.selected).must_be_kind_of Slack::User

      @test_workspace.select_by_id(GENERAL CHANNEL ID, :CHANNEL)
      expect(@test_workspace.selected).must_be_kind_of Slack::Channel
    end
  end

  xdescribe "show details" do
    it "raises an error when invalid @selected is present" do
      expect{(@test_workspace.show_details)}.must_raise ArgumentError
    end
  end

  xdescribe "post message" do
    it "raises an error when invalid @selected is present" do
      expect{(@test_workspace.post_message)}.must_raise ArgumentError
    end
  end

end