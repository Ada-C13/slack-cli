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

  describe "select" do
    before do
      VCR.use_cassette("workspace_initialize") do
        @workspace = Workspace.new
      end
    end

    it "updates @selected with instance of Channel that matches the given valid channel input" do
      expect(@workspace.selected).must_be_nil

      @workspace.select("CV83W5SS3")

      expect(@workspace.selected).wont_be_nil
      expect(@workspace.selected).must_be_kind_of Channel
    end

    it "updates @selected with instance of User that matches the given valid user input" do
      expect(@workspace.selected).must_be_nil

      @workspace.select("USLACKBOT")

      expect(@workspace.selected).wont_be_nil
      expect(@workspace.selected).must_be_kind_of User
    end

    it "returns the Channel object that matches a given valid channel input" do
      expect(@workspace.select("random")).must_be_kind_of Channel
      expect(@workspace.select("random").slack_id).must_equal "CV83W5SS3"
    end

    it "returns the User object that matches a given valid user input" do
      expect(@workspace.select("slackbot")).must_be_kind_of User
      expect(@workspace.select("slackbot").slack_id).must_equal "USLACKBOT"
      expect(@workspace.select("slackbot").real_name).must_equal "Slackbot"
    end

    it "returns false if input matches neither a user's nor channel's data" do
      expect(@workspace.select("InVaLIdSlACKcrEdS")).must_equal false
    end

    it "raises an ArgumentError if input provided is not a string" do
      channel = Channel.new("CUTE4M96W", "random", "random work-based matters", 5)
      user = User.new("USLACKBOT", "slackbot", "Slackbot", "zenning out with tea", "🍵")
      invalid_inputs = [channel, user, 1, 1.0, false, true, nil]

      invalid_inputs.each do |input|
        expect{ @workspace.select(input) }.must_raise ArgumentError, "Provided input is not a string"
      end
    end
  end
end