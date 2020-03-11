require_relative "test_helper"

describe "Initailize" do
   before do
      @workspace = Workspace.new
    end

  it "Creates a new instance of workspace" do
    expect(@workspace).must_be_kind_of Workspace
    expect(@workspace).must_respond_to :users
    expect(@workspace).must_respond_to :channels
  end

  it "Returns empty array for users" do
    expect(@workspace.users).must_be_kind_of Array
    expect(@workspace.users).must_be_empty 
  end

   it "Returns empty array for channels" do
    expect(@workspace.channels).must_be_kind_of Array
    expect(@workspace.channels).must_be_empty 
  end
end
