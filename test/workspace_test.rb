require_relative "test_helper"
require_relative "../lib/workspace"

describe "Workspace" do
  before do
    VCR.use_cassette("workspace-initialize") do
      @workspace = Slack::Workspace.new
    end
  end
  describe "initialize" do
    it "is an instance of Workspace" do
      expect(@workspace).must_be_kind_of Slack::Workspace
    end
    it "has array of Users" do
      expect(@workspace.users).must_be_kind_of Array
      @workspace.users.each do |user|
        expect(user).must_be_kind_of Slack::User
      end
    end
    it "has array of Channels" do
      expect(@workspace.channels).must_be_kind_of Array
      @workspace.channels.each do |channel|
        expect(channel).must_be_kind_of Slack::Channel
      end
    end
  end
end
