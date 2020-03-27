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

  describe "#select_user" do
    it "select a user by id" do
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

    it "select a user by name" do
      VCR.use_cassette("slack") do
        #Arrange
        workspace = SlackCLI::Workspace.new()
        #Act
        workspace.select_user("slackbot")
        #Assert
        expect(workspace.selected_user.name).must_equal "slackbot"
      end
    end
  end

  describe "#selected_channel" do
    it "select a channel by id" do
      VCR.use_cassette("slack") do
        #Arrange
        workspace = SlackCLI::Workspace.new()
        channel_id = workspace.channels[0].slack_id
        #Act
        workspace.select_channel(channel_id)
        #Assert
        expect(workspace.selected_channel).must_equal workspace.channels[0]
      end
    end

    it "select a channel by name" do
      VCR.use_cassette("slack") do
        #Arrange
        workspace = SlackCLI::Workspace.new()
        #Act
        workspace.select_channel("general")
        #Assert
        expect(workspace.selected_channel.name).must_equal "general"
      end
    end
  end

  # write a test for 1, select user by name, 2. select channel by id and by name

  describe "#send_message" do
    it "sends a message to a user" do
      VCR.use_cassette("send_message") do
        workspace = SlackCLI::Workspace.new()
        workspace.select_user("USLACKBOT")

        expect(workspace.send_message("what is for lunch?")).must_equal true
      end
    end

    it "sends a message to a channel" do
      VCR.use_cassette("send_message") do
        workspace = SlackCLI::Workspace.new()
        workspace.select_channel("CV8PR7M4M")

        expect(workspace.send_message("do you need help with your project?")).must_equal true
      end
    end
  end
end
