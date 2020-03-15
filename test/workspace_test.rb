require_relative 'test_helper'

describe "Workspace" do
  before do
    @workspace = nil 
    VCR.use_cassette("workspace_class") do
      @workspace = Workspace.new
    end
  end

  describe "Initializer" do
    it "can instantiate a instance of workspace" do
      expect(@workspace).must_be_kind_of Workspace
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.channels).must_be_kind_of Array
    end 
  end

  describe "select" do
    it "can select a user from a user ID" do
      @workspace.select_user("USLACKBOT")
      expect(@workspace.selected).must_be_kind_of User
      expect(@workspace.selected.real_name).must_equal "Slackbot"
    end

    it "can select a channel from a channel ID" do
      @workspace.select_channel("CV86T0TPY")
      expect(@workspace.selected).must_be_kind_of Channel
      expect(@workspace.selected.nickname).must_equal "random"
    end
  end

  describe "show details" do
    it "can display details of selected channel" do
      @workspace.select_channel("CV86T0TPY")
      # selected channel => "random"
      message = "here are the details for this Channel:\nID: CV86T0TPY\nnickname: random\ntopic: Non-work banter and water cooler conversation\nmember_num: 5"
      expect(@workspace.show_details).must_equal message
    end

    it "can display details of selected user" do
      @workspace.select_user("USLACKBOT")
      # selected channel => "slackbot"
      message = "here are the details for this User:\nID: USLACKBOT\nnickname: slackbot\nreal name: Slackbot\nstatus: \nemoji:"
      expect(@workspace.show_details).must_equal message
    end

  end
end