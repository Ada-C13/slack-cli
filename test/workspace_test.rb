require_relative "test_helper"
require_relative "../lib/channel"
require_relative "../lib/user"

describe "Workspace" do
  describe "initialize" do
    before do
      VCR.use_cassette("workspace_initialize") do
        @workspace = Workspace.new
      end
    end

    it "creates a new instance of Workspace" do
      expect(@workspace).must_be_kind_of Workspace
      expect(@workspace).must_respond_to :users
      expect(@workspace).must_respond_to :channels
    end

    it "creates an array of Users" do
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.users[0]).must_be_kind_of User
    end

    it "creates an array of Channels" do
      expect(@workspace.channels).must_be_kind_of Array
      expect(@workspace.channels[0]).must_be_kind_of Channel
    end

    it "verifies that nothing is selected currently" do
      expect(@workspace.selected).must_be_nil
    end
  end

  describe "validate_selected" do
    before do
      VCR.use_cassette("workspace_initialize") do
        @workspace = Workspace.new
      end
    end

    it "returns true if input matches a channel's data" do
      expect(@workspace.validate_selected("CV83W5SS3")).must_equal true
      expect(@workspace.validate_selected("random")).must_equal true
    end

    it "returns true if input matches a user's data" do
      expect(@workspace.validate_selected("USLACKBOT")).must_equal true
      expect(@workspace.validate_selected("slackbot")).must_equal true
    end

    it "returns false if input matches neither a user's nor channel's data" do
      expect(@workspace.validate_selected("INVALIDSLACKID")).must_equal false
    end

    it "raises an ArgumentError if input provided is not a string" do
      channel = Channel.new("CUTE4M96W", "random", "random work-based matters", 5)
      user = User.new("USLACKBOT", "slackbot", "Slackbot", "zenning out with tea", "🍵")
      invalid_inputs = [channel, user, 1, 1.0, false, true, nil]

      invalid_inputs.each do |input|
        expect{ @workspace.validate_selected(input) }.must_raise ArgumentError, "Provided input is not a string"
      end
    end
  end

  describe "update_select" do
    it "updates the selected instance varaible value" do
      
    end
  end
end
