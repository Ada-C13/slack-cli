require_relative "test_helper"

describe "initialize" do
  before do
    @workspace = Workspace.new
  end

  it "creates a new instance of Workspace" do
    expect(@workspace).must_be_kind_of Workspace
    expect(@workspace).must_respond_to :users
    expect(@workspace).must_respond_to :channels
  end

  it "initializes @users to be an empty array" do 
    expect(@workspace.users).must_be_kind_of Array
    expect(@workspace.users).must_be_empty
  end

  it "initializes @channels to be an empty array" do 
    expect(@workspace.channels).must_be_kind_of Array
    expect(@workspace.channels).must_be_empty
  end

  
end