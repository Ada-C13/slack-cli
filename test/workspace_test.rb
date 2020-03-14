require_relative 'test_helper'

describe "Workspace class" do
  before do
    VCR.use_cassette("initialze workspace object") do
      @workspace = Workspace.new
    end
  end

  describe "workspace object initialize" do
    
    it "creates a workspace object" do
      expect(@workspace).must_be_instance_of Workspace
    end

    it "properly fills in instance variables" do
      expect(@workspace.users.count).must_equal 11
      expect(@workspace.users).must_be_instance_of Array
      expect(@workspace.selected).must_be_nil
      expect(@workspace.users[0]).must_be_instance_of User  
      expect(@workspace.channels.count).must_equal 3
      expect(@workspace.channels).must_be_instance_of Array
      expect(@workspace.channels[0]).must_be_instance_of Channel  
    end
  end

  describe "select_channel" do
    it "selects a channel given a slack_id or channel name" do
      name = "general"
      selected_channel = @workspace.select_channel(name)
      id = "CUTE4M96W"
      expect(selected_channel).must_be_instance_of Channel
      expect(selected_channel.name).must_equal name
      expect(@workspace.select_channel(id).slack_id).must_equal id
      expect(@workspace.select_channel("afasdf")).must_equal "Channel not found!"
    end
  end

  describe "select_users" do
    it "selects a user given a slack_id or username" do
      user = "slackbot"
      selected_user = @workspace.select_user(user)
      id = "USLACKBOT"
      expect(selected_user).must_be_instance_of User
      expect(selected_user.name).must_equal user
      expect(@workspace.select_user(id).slack_id).must_equal id
      expect(@workspace.select_user("afasdf")).must_equal "User not found!"
    end
  end
end