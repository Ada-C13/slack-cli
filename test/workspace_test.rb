require_relative "test_helper"

describe "initialize" do
  it "creates a new instance of Workspace" do
    workspace = Workspace.new

    expect(workspace).must_be_kind_of Workspace
    # expect(workspace).must_respond_to :users
    # expect(workspace).must_respond_to :channels
  end
end