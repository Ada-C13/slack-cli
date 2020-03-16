require_relative "test_helper"

describe "Workspace class" do 
  before do
    @users = "slackbot"
    @channels = "general" 
    @selected = "slackbot"
    @workspace = Workspace.new(users: @users, channels: @channels, selected: @selected)
  end
  describe "constructor" do
    it "instance of workspace class" do
      expect (@workspace).must_be_instance_of Workspace
    end
    it "can access attributes" do
      expect(@users).must_equal @users
      expect(@channels).must_equal @channels
      expect(@selected).must_equal @selected
    end
  end
end
