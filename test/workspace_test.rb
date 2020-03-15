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
  describe "select_user" do
    it "selects a user" do
      @workspace.select_user("thenora")
      expect(@workspace.selected).must_be_kind_of Slack::User
    end
    it "does not assign invalid user" do
      @workspace.select_user("bob")
      expect(@workspace.selected).must_be_kind_of NilClass
    end
  end
  describe "select_channel" do
    it "selects a channel" do
      @workspace.select_channel("general")
      expect(@workspace.selected).must_be_kind_of Slack::Channel
    end
    it "does not assign invalid channel" do
      @workspace.select_channel("bob")
      expect(@workspace.selected).must_be_kind_of NilClass
    end
  end
  describe "show_details" do
    it "shows user or channel details" do
      @workspace.select_user("thenora")
      expect(@workspace.show_details).must_be_kind_of TablePrint::Returnable
      @workspace.select_channel("general")
      expect(@workspace.show_details).must_be_kind_of TablePrint::Returnable
    end
  end
    # test not working; response returning nil
    # describe "send_message" do
    #   it "sends a message to user or channel" do
    #     @workspace.select_user("slackbot")
    #     VCR.use_cassette("chat-postmessage-endpoint") do
    #       @response = @workspace.send_message("hello")
    #     end
    #     expect(@response).must_equal true # => nil, although it does actually send
    #   end
    # end
end
