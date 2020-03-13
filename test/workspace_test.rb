require_relative "test_helper"

describe "initialize" do
  before do
    VCR.use_cassette("workspace_initialize") do
      @workspace = Workspace.new
    end
  end

  it "creates a new instance of Workspace" do
    expect(@workspace).must_be_kind_of Workspace
    expect(@workspace).must_respond_to :users
    expect(@workspace).must_respond_to :channels
  end

  it "initializes @users to be an array of Users" do
    expect(@workspace.users).must_be_kind_of Array
    expect(@workspace.users[0]).must_be_kind_of User
  end

  it "initializes @channels to be an array of Channels" do
    expect(@workspace.channels).must_be_kind_of Array
    expect(@workspace.channels[0]).must_be_kind_of Channel
  end

  it "verifies nothing is selected currently" do
    expect(@workspace.selected).must_be_nil
  end
end
