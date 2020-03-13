require_relative "test_helper"
require_relative '../lib/slack'

describe "main" do
  it "creates an instance of a Workspace class" do
    workspace = nil
    VCR.use_cassette("slack") do
      workspace = SlackCLI::Workspace.new
    end

    expect(workspace).must_be_instance_of SlackCLI::Workspace
  end 
end