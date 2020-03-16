require_relative "test_helper"
require_relative '../lib/workspace'

describe "Workspace" do
  describe "Initialize" do
    before do
      VCR.use_cassette("create_workspace") do
        @workspace = Workspace.new
      end
    end

    it "will create a new Workplace" do
      expect(@workspace).must_be_instance_of Workspace
    end

    it "will have an array of Channels and Users" do
      expect(@workspace.channels).must_be_instance_of Array
      expect(@workspace.users).must_be_instance_of Array
    end
  end

  describe "select_channel(channel_name)" do
    before do 
      VCR.use_cassette("create_workspace")do
      @workspace = Workspace.new
    end
    end
  
    it "will return an instance of Channel based on the user input" do
      @workspace.select_channel("random")
      expect(@workspace.selected).must_be_instance_of Channel
      expect(@workspace.selected.name).must_equal "random"
    end
  end

  describe "select_channel(channel_name)" do
    before do 
      VCR.use_cassette("create_workspace")do
      @workspace = Workspace.new
    end
    end
  
    it "will return a Channel based on the user input" do
      @workspace.select_channel("random")
      expect(@workspace.selected).must_be_instance_of Channel
      expect(@workspace.selected.name).must_equal "random"
    end
  end

  describe "select_user(user_name)" do
    before do 
      VCR.use_cassette("create_workspace")do
      @workspace = Workspace.new
    end
    end
  
    it "will return an instance of User based on the user input" do
      @workspace.select_user("Joseph")
      expect(@workspace.selected).must_be_instance_of User
      expect(@workspace.selected.real_name).must_equal "Joseph"
    end
  end
end  

