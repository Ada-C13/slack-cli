require_relative "test_helper"
require_relative "../lib/workspace"

describe "Workspace" do
  before do 
    VCR.use_cassette("workspace-test") do 
      @test_workspace = Workspace.new()
    end 
  end 

  describe "initialize" do 
    it "creates an instance of a Workspace object" do 
      expect(@test_workspace).must_be_kind_of Workspace
    end 

    it "creates an array of User objects" do 
      expect(@test_workspace.users).must_be_kind_of Array
      expect(@test_workspace.users.length).must_equal 11 # Assumption: This workspace will not have any more users created
      
    end 

    it "creates an array of Channel objects" do 
      expect(@test_workspace.channels).must_be_kind_of Array
      expect(@test_workspace.channels.length).must_equal 3 # Assumption: This workspace will not have any more channels created 
    end 
  end

  xdescribe "select_channel" do 
    xit "" do 
    end 
  end 

  xdescribe "select_user" do 
  end 

  xdescribe "show_details" do 
  end 

  xdescribe "send_message" do 
  end 
  
end