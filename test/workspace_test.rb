require_relative "test_helper"
require "simplecov"

describe "Workspace class" do
  it "create a workspace" do
    VCR.use_cassette("slack") do

      #Arrange

      #Act
      workspace = Workspace.new()
      #Assert
      expect(workspace).must_be_instance_of Workspace
    end
  end

  it "check workspace.new is a list of users" do
    VCR.use_cassette("slack") do
      #Arrange & Act
      workspace = Workspace.new()

      #Assert
      expect(workspace.users).must_be_instance_of Array
      workspace.users.each do |user|
        expect(user).must_be_instance_of User
      end
    end
  end

  it "check workspace.new is a list of channel" do
    VCR.use_cassette("slack") do
      #Arrange & Act
      workspace = Workspace.new()

      #Assert
      expect(workspace.channels).must_be_instance_of Array
      workspace.channels.each do |channel|
        expect(channel).must_be_instance_of Channel
      end
    end
  end
end
