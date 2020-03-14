require_relative 'test_helper'
require_relative '../lib/workspace'


describe "Workspace" do 
  before do 
    VCR.use_cassette("workspace-endpoint") do
      @new_workspace = SlackApp::Workspace.new
    end
  end 
  it "can be created" do 
    
    expect(@new_workspace).must_be_kind_of SlackApp::Workspace 
  end 
  
  it "inititalize list channels" do 
    expect(@new_workspace.channels).must_be_kind_of Array
  end 
  
  it "inititalize list users" do 
    expect(@new_workspace.users).must_be_kind_of Array
  end 
  
  it "inititalize list channels" do 
    expect(@new_workspace.channels[0]).must_be_kind_of SlackApp::Channel
  end 

  it "inittialize list " do 
    expect(@new_workspace.users[0]).must_be_kind_of SlackApp::User
  end 

  describe "select channel" do 
    it "can find the channel by name" do 
      selected = @new_workspace.select_channel("slackcli")
      expect(@new_workspace.selected.name).must_equal "slackcli"
    end 
    it "assign selected with Nil if not found" do 
      selected = @new_workspace.select_channel("iamnotachannelname")
      expect(@new_workspace.selected).must_be_nil
    end 
    it "handles any string case" do 
      selected = @new_workspace.select_channel("slAckcLi")
      expect(@new_workspace.selected.name).must_equal "slackcli"
    end 
    it "can be find by slack id" do 
      selected = @new_workspace.select_channel("CUURD2M5Z")
      expect(@new_workspace.selected.slack_id).must_equal "CUURD2M5Z"
    end 
    it "handles any string case" do 
      selected = @new_workspace.select_channel("cUURD2M5z")
      expect(@new_workspace.selected.slack_id).must_equal "CUURD2M5Z"
    end 
  end 
  describe "select user" do 
    it "can find the user by name" do 
      selected = @new_workspace.select_user("corinna.fabre")
      expect(@new_workspace.selected.name).must_equal "corinna.fabre"
    end 

    it "assign selected with Nil if not found" do 
      selected = @new_workspace.select_user("iamnotausername")
      expect(@new_workspace.selected).must_be_nil
    end 
    it "handles any string case" do 
      selected = @new_workspace.select_user("cOrinna.fabRe")
      expect(@new_workspace.selected.name).must_equal "corinna.fabre"
    end 
    it "can be find by slack id" do 
      selected = @new_workspace.select_user("UUUSFT2AX")
      expect(@new_workspace.selected.slack_id).must_equal "UUUSFT2AX"
    end 
    it "handles any string case" do 
      selected = @new_workspace.select_user("uUUSFT2aX")
      expect(@new_workspace.selected.slack_id).must_equal "UUUSFT2AX"
    end 
  end 
end 