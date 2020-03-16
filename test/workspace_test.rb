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
      user_input = "CV7V4KYLF"
      @workspace_inst.select_channel(user_input)

      expect(@workspace_inst.selected.name).must_equal "random"
      expect(@workspace_inst.selected).must_be_kind_of Channel
    end
  end

end
