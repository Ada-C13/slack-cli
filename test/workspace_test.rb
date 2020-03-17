require_relative "test_helper"
require_relative "../lib/workspace"

describe "workspace" do
  before do
    @test_workspace = Slack::Workspace.new
  end

  describe "initialize" do

    it "creates a workspace object" do
      expect(@test_workspace).must_be_kind_of Slack::Workspace
    end

    it "returns @users as an array" do
      expect(@test_workspace.users).must_be_kind_of Array 
    end

    it "contains only User objects in @user" do
      expect(@test_workspace.users.all? { |user| user.kind_of? Slack::User}).must_equal true
    end

    it "returns @channels as an array" do
      expect(@test_workspace.channels).must_be_kind_of Array
    end

    it "contains only Channel objects in @channels" do
      expect(@test_workspace.channels.all? { |channel| channel.kind_of? Slack::Channel}).must_equal true
    end
    
    it "initializes @selected to nil" do
      expect(@test_workspace.selected).must_be nil 
    end

  end

  describe "select_by_id" do
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

  describe "show details" do
    it "raises an error when invalid @selected is present" do
      expect{(@test_workspace.show_details)}.must_raise ArgumentError
    end
  end

  describe "post message" do
    it "raises an error when invalid @selected is present" do
      expect{(@test_workspace.post_message)}.must_raise ArgumentError
    end
  end

end