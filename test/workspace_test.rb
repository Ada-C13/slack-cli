require_relative "test_helper"
require "simplecov"

describe "Workspace class" do
  it "create a workspace" do
    VCR.use_cassette("slack") do

      #Arrange

      #Act
      workspace = SlackCLI::Workspace.new()
      #Assert
      expect(workspace).must_be_instance_of SlackCLI::Workspace
    end
  end

  it "check workspace.new is a list of users" do
    VCR.use_cassette("slack") do
      #Arrange & Act
      workspace = SlackCLI::Workspace.new()

      #Assert
      expect(workspace.users).must_be_instance_of Array
      workspace.users.each do |user|
        expect(user).must_be_instance_of SlackCLI::User
      end
    end
  end

  it "check workspace.new is a list of channel" do
    VCR.use_cassette("slack") do
      #Arrange & Act
      workspace = SlackCLI::Workspace.new()

      #Assert
      expect(workspace.channels).must_be_instance_of Array
      workspace.channels.each do |channel|
        expect(channel).must_be_instance_of SlackCLI::Channel
      end
    end
  end

  it "select a user" do
    VCR.use_cassette("slack") do
      #Arrange
      workspace = SlackCLI::Workspace.new()
      user_id = workspace.users[0].slack_id
      #Act
      workspace.select_user(user_id)
      #Assert
      expect(workspace.selected_user).must_equal workspace.users[0]
    end
  end
  # write a test for 1, select user by name, 2. select channel by id and by name
end
