require_relative 'test_helper.rb'

describe "workspace" do
  before do
    @new_workspace = nil
    VCR.use_cassette("new_workspace") do
      @new_workspace = Workspace.new
    end
  end
  
  it "can initialize workspace" do
    expect(@new_workspace).must_be_kind_of Workspace
    expect(@new_workspace.users).must_be_kind_of Array
    expect(@new_workspace.users[0]).must_be_kind_of User
    expect(@new_workspace.channels).must_be_kind_of Array
    expect(@new_workspace.channels[0]).must_be_kind_of Channel
    expect(@new_workspace.selected_user).must_equal nil
    expect(@new_workspace.selected_channel).must_equal nil
  end
  
  describe "select user method" do
    it "correctly selects a user based on name" do
      name = "slackbot"
      selected_user = @new_workspace.select_user(name)
      expect(selected_user).must_be_kind_of User
      expect(selected_user.name).must_equal name
      expect(selected_user.slack_id).must_equal "USLACKBOT"
    end

    it "correctly selects a user based on ID" do
      slack_id = "USLACKBOT"
      selected_user = @new_workspace.select_user(slack_id)
      expect(selected_user).must_be_kind_of User
      expect(selected_user.name).must_equal "slackbot"
      expect(selected_user.slack_id).must_equal slack_id
    end

    it "returns nil if user doesn't exist" do
      name = "thisuserdoesnotexist"
      selected_user = @new_workspace.select_user(name)
      expect(selected_user).must_equal nil
    end
  end

  describe "select channel method" do
    it "correctly selects a channel based on name" do
      name = "general"
      slack_id = @new_workspace.channels.find{ |channel| channel.name == name}.slack_id
      selected_channel = @new_workspace.select_channel(name)
      expect(selected_channel).must_be_kind_of Channel
      expect(selected_channel.name).must_equal name
      expect(selected_channel.slack_id).must_equal slack_id
    end

    it "correctly selects a channel based on ID" do
      slack_id = @new_workspace.channels.find{ |channel| channel.name == "general"}.slack_id     
      selected_channel = @new_workspace.select_channel(slack_id)
      expect(selected_channel).must_be_kind_of Channel
      expect(selected_channel.name).must_equal "general"
      expect(selected_channel.slack_id).must_equal slack_id
    end

    it "returns nil if channel doesn't exist" do
      name = "thischanneldoesnotexist"
      selected_channel = @new_workspace.select_channel(name)
      expect(selected_channel).must_equal nil
    end
  end



end