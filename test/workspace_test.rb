require_relative "test_helper"

describe "Workspace" do
  
  describe "Initialize" do

    before do
      @workspace = SlackCLI::Workspace.new
    end

    it "can create an instance of Workspace" do
      VCR.use_cassette("workspace_class") do
        expect(@workspace).must_be_kind_of SlackCLI::Workspace
      end
    end
  end

  describe "list_channels" do

    before do
      @workspace = SlackCLI::Workspace.new
    end

    it "can blahblah something channels" do
      VCR.use_cassette("workspace_class") do
        expect(@workspace.list_channels[0].name).must_equal "slackcli"
        expect(@workspace.list_channels.length).must_equal 5
        expect(@workspace.list_channels).must_be_kind_of Array
      end
    end
  end

  describe "list_users" do

    before do
      @workspace = SlackCLI::Workspace.new
    end

    it "can blahblah something users" do
      VCR.use_cassette("workspace_class") do
        expect(@workspace.list_users[0].name).must_equal "Slackbot"
        expect(@workspace.list_users.length).must_equal 8
        expect(@workspace.list_users).must_be_kind_of Array
      end
    end
  end

  describe "select_channel" do

    before do
      @workspace = SlackCLI::Workspace.new
    end

    it "can blahblah selecting channel stuff" do
      VCR.use_cassette("workspace_class") do

        expect(@workspace.select_channel("random").slack_id).must_equal "CV85Q6S0P"

        expect(@workspace.select_channel("honeybucket").slack_id).must_equal "CVAEAU1LN"
      end
    end
  end

  describe "select_user" do

    before do
      @workspace = SlackCLI::Workspace.new
    end

    it "can blahblah selecting users stuff" do
      VCR.use_cassette("workspace_class") do

        expect(@workspace.select_user("Slackbot").username).must_equal "slackbot"

        expect(@workspace.select_user("Slackbot").name).must_equal "Slackbot"
      end
    end
  end

  describe "show_details" do

    # before do
      
    # end

    it "can blahblah showing details" do
      VCR.use_cassette("workspace_class") do
        @workspace = SlackCLI::Workspace.new
        @workspace.select_user("Slackbot")
        expect(@workspace.show_details.username).must_equal "slackbot"
        expect(@workspace.show_details.slack_id).must_equal "USLACKBOT"
        expect(@workspace.select_user("Slackbot")).must_be_kind_of SlackCLI::User
      end
    end
  end

  describe "send_message" do

    # before do
    #   @workspace = SlackCLI::Workspace.new
    # end

    # it "can blahblah selecting users stuff" do
    #   VCR.use_cassette("workspace_class") do

    #     expect(@workspace.select_user("Slackbot").length).must_equal 3

    #     expect(@workspace.select_user("random")).must_be_kind_of Array
    #   end
    # end
  end
end
