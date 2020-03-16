require_relative "test_helper"

describe "TEST FOR WORKSPACE FILE" do
  before do
    VCR.use_cassette("workspace_creation") do
      @workspace = Workspace.new
    end
  end
  describe "WORKSPACE" do
    it "Creates a new instance of Workspace" do
      expect(@workspace).must_be_kind_of Workspace
      expect(@workspace).must_respond_to :users
      expect(@workspace).must_respond_to :channels
    end
  end

  describe "USER" do
    it "initializes @users an array of users " do
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.users[0]).must_be_kind_of User
    end

    it "can make a selection of a USER by name" do
      selection = "norshonda.warren"
      expect(@workspace.select_user(selection)).must_be_kind_of User
    end

    it "can make a selection and show details" do
      @workspace.select_user("norshonda.warren")
      expect(@workspace.show_details).must_be_kind_of Array
    end

    it "returns nil if selection of a USER by name can't be found" do
      expect(@workspace.select_user("bogus")).must_be_nil
    end

    it "can make a selection of a USER by slack_id" do
      selection = "UUW5E7SF3"
      expect(@workspace.select_user(selection)).must_be_kind_of User
    end
  end

  describe "CHANNEL" do
    it "initializes @channels an array of channels" do
      expect(@workspace.channels).must_be_kind_of Array
      expect(@workspace.channels[0]).must_be_kind_of Channel
    end

    it "can make a selection of a Channel by name" do
      @workspace.select_channel("general")
      expect(@workspace.selected).must_be_kind_of Channel
      expect(@workspace.selected.name).must_equal "general"
    end

    it "can make a selection and show details" do
      @workspace.select_channel("general")
      expect(@workspace.show_details).must_be_kind_of Array
    end

    it "can make a selection of a Channel by slack id" do
      @workspace.select_channel("CUTE4M96W")
      expect(@workspace.selected).must_be_kind_of Channel
      expect(@workspace.selected.slack_id).must_equal "CUTE4M96W"
    end
  end
end
