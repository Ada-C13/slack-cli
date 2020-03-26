require_relative "test_helper"
require_relative "../lib/workspace"
require_relative "../lib/user"
require_relative "../lib/channel"

describe "Workspace class" do
  before do
    VCR.use_cassette("workspace") do
      @workspace_inst = Workspace.new
    end
  end

  describe "initialize" do
    it "is an instance of Workspace" do
      expect(@workspace_inst).must_be_kind_of Workspace
    end

    it "has a list of users" do
      expect(@workspace_inst.users).must_be_kind_of Array
      expect(@workspace_inst.users[0]).must_be_kind_of User
    end

    it "has a list of channels" do
      expect(@workspace_inst.channels).must_be_kind_of Array
      expect(@workspace_inst.channels[0]).must_be_kind_of Channel
    end
  end

  describe "select_channel" do
    it "selects a channel from a slack_id" do
      user_input = "CV7V4KYLF" # random channel slack_id
      @workspace_inst.select_channel(user_input)

      expect(@workspace_inst.selected.name).must_equal "random"
      expect(@workspace_inst.selected).must_be_kind_of Channel
    end

    it "selects a channel from a slack_id even if entered in lowercase" do
      user_input = "cv7v4kylf" # random channel slack_id
      @workspace_inst.select_channel(user_input)

      expect(@workspace_inst.selected.name).must_equal "random"
      expect(@workspace_inst.selected).must_be_kind_of Channel
    end

    it "selects a channel from a name" do
      user_input = "random"
      @workspace_inst.select_channel(user_input)

      expect(@workspace_inst.selected.slack_id).must_equal "CV7V4KYLF"
      expect(@workspace_inst.selected).must_be_kind_of Channel
    end

    it "selects a channel from a name, regardless of case" do
      user_input = "RanDoM"
      @workspace_inst.select_channel(user_input)

      expect(@workspace_inst.selected.slack_id).must_equal "CV7V4KYLF"
      expect(@workspace_inst.selected).must_be_kind_of Channel
    end

    it "sets selected to nil if no match for slack_id or name" do
      user_input = "adaisreallyawesome"
      @workspace_inst.select_channel(user_input)
      
      expect(@workspace_inst.selected).must_be_nil
    end
  end

  describe "select_user" do
    it "selects a user from a slack_id" do
      user_input = "USLACKBOT"
      @workspace_inst.select_user(user_input)

      expect(@workspace_inst.selected.name).must_equal "slackbot"
      expect(@workspace_inst.selected).must_be_kind_of User
    end

    it "selects a user from a slack_id regardless of case" do
      user_input = "uSlaCkbot" 
      @workspace_inst.select_user(user_input)

      expect(@workspace_inst.selected.name).must_equal "slackbot"
      expect(@workspace_inst.selected).must_be_kind_of User
    end

    it "selects a user from a name" do
      user_input = "slackbot"
      @workspace_inst.select_user(user_input)

      expect(@workspace_inst.selected.slack_id).must_equal "USLACKBOT"
      expect(@workspace_inst.selected).must_be_kind_of User
    end

    it "selects a user from a name, regardless of case" do
      user_input = "SlacKBot"
      @workspace_inst.select_user(user_input)

      expect(@workspace_inst.selected.slack_id).must_equal "USLACKBOT"
      expect(@workspace_inst.selected).must_be_kind_of User
    end

    it "sets selected to nil if no match for slack_id or name" do
      user_input = "adaisreallyawesome"
      @workspace_inst.select_user(user_input)
      
      expect(@workspace_inst.selected).must_be_nil
    end
  end

  describe "show_details" do
    it "returns message if no user or channel selected" do
      expect(@workspace_inst.show_details).must_equal "No user or channel was selected."
    end
  end
end
