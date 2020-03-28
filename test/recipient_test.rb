require_relative "test_helper"

describe "Recipeint class" do
  describe "#send_message" do
    it "sends a message to a user" do
      VCR.use_cassette("send_message") do
        workspace = SlackCLI::Workspace.new
        #Arrange & Act
        user = workspace.select_user("USLACKBOT")
        #
        expect(user.send_message("hello can you chat?", user)).must_equal true
      end
    end

    it "sends a message to a channel" do
      VCR.use_cassette("send_message") do
        workspace = SlackCLI::Workspace.new
        #Arrange & Act
        channel = workspace.select_channel("CV8PR7M4M")

        expect(channel.send_message("what is your channe_id", channel)).must_equal true
      end
    end

    it "raises Slack_Api_error by giving fake user_name" do
      VCR.use_cassette("send_message") do

        #Arrange & Act
        user = SlackCLI::User.new("sugarplum", "111111")

        expect { user.send_message("hello can you chat?", user) }.must_raise SlackCLI::SlackApiError
      end
    end
  end
end
