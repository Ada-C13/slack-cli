#coded along with Devin for Wave 1

require_relative "test_helper"
require_relative '../lib/workspace'

describe "Workspace" do
  before do 
    VCR.use_cassette("workspace-data") do
      @new_workspace = Workspace.new
    end
  end

  describe "initializes workspace" do
    it "creates instance of workspace" do
      expect(@new_workspace).must_be_kind_of Workspace
    end

    it "has array of users and channels" do
      expect(@new_workspace.channels).must_be_kind_of Array
      expect(@new_workspace.users).must_be_kind_of Array
      expect(@new_workspace.selected).must_equal nil
    end
  end

  describe "select_user and select_channel methods" do
    it "selects user based off user input" do
      @new_workspace.select_user("OLIVIAMULHOLLAND94")
      
      expect(@selected).must_be_kind_of User
      expect(@selected.name).must_equal "oliviamulholland94"
      expect(@selected.slack_id).must_equal "UV5GT0PBN"
    end

    it "selects channel based off user input" do
      @new_workspace.select_channel("RANDOM")
      
      expect(@selected).must_be_kind_of Channel
      expect(@selected.name).must_equal "random"
      expect(@selected.slack_id).must_equal "CV60NTK4G"
    end
  end





  
end