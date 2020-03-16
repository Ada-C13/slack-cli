require_relative "test_helper"
require_relative "../lib/workspace"

describe "Workspace" do 
  describe "initialize" do 
    it "is an instance of Workspace" do 
      result = {}
      VCR.use_cassette("workspace-endpoint") do 
        result = Slack::Workspace.new
      end 
      expect(result).must_be_instance_of Slack::Workspace
    end 
  end
end 