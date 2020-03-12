require_relative "test_helper"

describe "initialize" do

  def build_test_workspace
    Workspace.new
  end

  it "creates a new instance of Workspace" do
    VCR.use_cassette("load_workspace") do
      workspace = build_test_workspace 
      expect(workspace).must_be_kind_of Workspace
      expect(workspace).must_respond_to :users
      expect(workspace).must_respond_to :channels
    end
  end

  it "initializes @users to be an array of Users" do 
    VCR.use_cassette("load_workspace") do
      workspace = build_test_workspace 
      expect(workspace.users).must_be_kind_of Array
      expect(workspace.users[0]).must_be_kind_of User
    end
  end

  it "initializes @channels to be an array of Channels" do
    VCR.use_cassette("load_workspace") do 
      workspace = build_test_workspace 
      expect(workspace.channels).must_be_kind_of Array
      expect(workspace.channels[0]).must_be_kind_of Channel
    end
  end

  it "verifies nothing is selected currently" do
    VCR.use_cassette("load_workspace") do 
      workspace = build_test_workspace 
      expect(workspace.selected).must_be_nil
    end
  end
end