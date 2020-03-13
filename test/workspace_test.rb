require_relative "test_helper"

describe "Workspace" do
  before do
    VCR.use_cassette("workspace_creation") do
      @workspace = Workspace.new
    end
  end

  it "Creates a new instance of Workspace" do
    expect(@workspace).must_be_kind_of Workspace
    expect(@workspace).must_respond_to :users
    expect(@workspace).must_respond_to :channels
  end

  it "initializes @users an array of users " do
    expect(@workspace.users).must_be_kind_of Array
    expect(@workspace.users[0]).must_be_kind_of User
  end

  it "initializes @channels an array of channels" do
    expect(@workspace.channels).must_be_kind_of Array
    expect(@workspace.channels[0]).must_be_kind_of Channel
  end
end
