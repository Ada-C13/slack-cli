require_relative "test_helper"

describe "Workspace" do
  
  describe "Initialize" do

    it "can create an instance of Workspace" do
      VCR.use_cassette("workspace_class") do
        @workspace = SlackCLI::Workspace.new
        expect(@workspace).must_be_kind_of SlackCLI::Workspace
      end
    end
  end

  describe "select_channel" do

    it "can return a channel instance" do
      VCR.use_cassette("workspace_class") do
        @workspace = SlackCLI::Workspace.new
        expect(@workspace.select_channel("random").slack_id).must_equal "CV85Q6S0P"
        expect(@workspace.select_channel("general").slack_id).must_equal "CV8FWUH8W"
        expect(@workspace.select_channel("honeybucket").slack_id).must_equal "CVAEAU1LN"
      end
    end

    it "returns a channel as a Channel instance" do
      VCR.use_cassette("workspace_class") do
        @workspace = SlackCLI::Workspace.new
        expect(@workspace.select_channel("random")).must_be_kind_of SlackCLI::Channel
        expect(@workspace.select_channel("general")).must_be_kind_of SlackCLI::Channel
        expect(@workspace.select_channel("honeybucket")).must_be_kind_of SlackCLI::Channel
      end
    end
  end

  describe "select_user" do

    it "can return a user instance" do
      VCR.use_cassette("workspace_class") do
        @workspace = SlackCLI::Workspace.new
        selected_user = @workspace.select_user("Slackbot")
        expect(selected_user.username).must_equal "slackbot"
        expect(selected_user.slack_id).must_equal "USLACKBOT"
        expect(selected_user.name).must_equal "Slackbot"
      end
    end

    it "returns a user as a User instance" do
      VCR.use_cassette("workspace_class") do
        @workspace = SlackCLI::Workspace.new
        selected_user = @workspace.select_user("Slackbot")
        expect(selected_user).must_be_kind_of SlackCLI::User
      end
    end
  end

  describe "message_to_outbox" do

    it "can send a message to a user and confirm the message has been sent" do
      VCR.use_cassette("workspace_class") do
        @workspace = SlackCLI::Workspace.new
        @workspace.select_user("Slackbot")
        sent_message = @workspace.message_to_outbox("poop")
        expect(sent_message).must_equal "Message delivered!"
      end
    end

    it "can send a message to a user and confirm the message has been sent" do
      VCR.use_cassette("workspace_class") do
        @workspace = SlackCLI::Workspace.new
        @workspace.select_channel("honeybucket")
        sent_message = @workspace.message_to_outbox("poop")
        expect(sent_message).must_equal "Message delivered!"
      end
    end
  end

  describe "show_history" do

    it "can list a chat history" do
      VCR.use_cassette("workspace_class") do
        @workspace = SlackCLI::Workspace.new
        @workspace.select_channel("honeybucket")
        history = @workspace.show_history
        expect(history).must_be_kind_of Array
        expect(history.empty?).must_equal false
      end
    end
  end

  describe "set_reminder" do

    it "can set a reminder for the current user" do
      VCR.use_cassette("workspace_class") do
        @workspace = SlackCLI::Workspace.new
        reminder = @workspace.set_reminder("don't fall for it.", Time.utc(2020, 4, 1, 10))

        expect(reminder.parsed_response["ok"]).must_equal true

      end
    end
  end
end
