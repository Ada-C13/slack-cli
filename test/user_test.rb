require_relative "test_helper"
require "simplecov"

describe "User class" do
  it "creates a user" do
    #Arrange
    name = "Hannah"
    id = "0317"

    #Act
    user = SlackCLI::User.new(name, id)
    #Assert
    expect(user).must_be_instance_of SlackCLI::User
  end

  describe "#print_details" do
    it "prints detail for given user" do
      VCR.use_cassette("print_details") do
        # select a user
        workspace = SlackCLI::Workspace.new
        user = workspace.select_user("USLACKBOT")
        expect(user.print_details).must_be_instance_of Hash
      end
    end

    it "prints detail for given channel" do
      VCR.use_cassette("print_details") do
        # select a channel
        workspace = SlackCLI::Workspace.new
        channel = workspace.select_channel("general")
        expect(channel.print_details).must_be_instance_of Hash
      end
    end
  end
end
