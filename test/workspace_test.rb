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
      expect(@workspace.select_channel(id).name).must_equal name
      expect(@workspace.select_channel("afasdf")).must_equal "Channel not found!"
    end

    it "updates the selected instance variable" do
      name = "general"
      @workspace.select_channel(name)
      expect(@workspace.selected.name).must_equal name
    end
  end

  describe "select_users" do
    it "selects a user given a slack_id or username" do
      user = "slackbot"
      selected_user = @workspace.select_user(user)
      id = "USLACKBOT"
      expect(selected_user).must_be_instance_of User
      expect(selected_user.name).must_equal user
      expect(@workspace.select_user(id).name).must_equal user
      expect(@workspace.select_user("afasdf")).must_equal "User not found!"
    end

    it "updates the selected instance variable" do
      user = "slackbot"
      @workspace.select_user(user)
      expect(@workspace.selected.name).must_equal user
    end
  end

  describe "show_details" do
    it "returns the selected user/channel if one is selected" do
      user = "slackbot"
      @workspace.select_user(user)

      expect(@workspace.show_details.name).must_equal user
    end

    it "returns nil if no user was selected" do
      expect(@workspace.show_details).must_be_nil
    end
  end
end