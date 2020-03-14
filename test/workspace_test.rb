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
      expect(@workspace.users[0]).must_be_instance_of User  
      expect(@workspace.channels.count).must_equal 3
      expect(@workspace.channels[0]).must_be_instance_of Channel  
    end
  end
end