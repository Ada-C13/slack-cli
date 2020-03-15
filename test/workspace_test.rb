require_relative "test_helper"
require_relative "../lib/workspace"
require 'table_print'


describe "Workspace instantiation" do
  it "creates an instance of Workspace" do
    VCR.use_cassette("Workspace initialized") do
      expect(Workspace.new).must_be_instance_of Workspace
    end
  end
end

describe "show_details" do
  VCR.use_cassette("workspace-show-details") do
    @workspace = Workspace.new
  end

  new_user = @workspace.select_user("habenup")

  it "Will return a table print of details" do
    expect(new_user.details).must_be_kind_of TablePrint::Returnable
  end

  new_channel = @workspace.select_channel("random")

  it "Will return a table print of details" do
    expect(new_channel.details).must_be_kind_of TablePrint::Returnable
  end
end

describe "Select User" do

  VCR.use_cassette("workspace-select-user") do
    @workspace = Workspace.new
  end

  new_user = @workspace.select_user("habenup")
  p new_user

  it "Will return select user" do
    expect(User.name).must_be_kind_of String
  end

end

