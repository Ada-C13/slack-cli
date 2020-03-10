require_relative "test_helper"

describe "Initailize" do
  it "Creates a new instance of workspace" do
    workspace = Workspace.new
    expect(workspace).must_be_kind_of Workspace
  end
end
