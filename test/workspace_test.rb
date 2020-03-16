require_relative "test_helper"
require_relative "../lib/workspace"
require 'table_print'

describe "Workspace class" do
  describe "Workspace instantiation" do
    it "creates an instance of Workspace" do
      VCR.use_cassette("workspace-initialized") do
        expect(Slack_cli::Workspace.new).must_be_instance_of Slack_cli::Workspace
      end
    end
  end

  describe "Select an specific user" do
    it "select_user" do
      VCR.use_cassette("workspace-select-user") do
        @workspace = Slack_cli::Workspace.new
      end
      # Override the gets method to test with a hard code user, insted of asking the user.
      def @workspace.gets
        "Vera"
      end
      @selected = @workspace.select_user
    
      expect(@workspace.selected).must_be_instance_of Slack_cli::User
      expect(@workspace.selected.name).must_equal "lizeth.veraro"
    end

    it "selected equals to nil when user does not exist" do
      VCR.use_cassette("workspace-select-user") do
        @workspace = Slack_cli::Workspace.new
      end
      # Override the gets method to test with a hard code user, insted of asking the user.
      def @workspace.gets
        "UserNil"
      end
      @selected = @workspace.select_user
    
      # expect(@workspace.selected).must_be_instance_of Slack_cli::User
      assert_nil(@workspace.selected)
    end
  end

  describe "Select an specific channel" do
    it "select_channel" do
      VCR.use_cassette("workspace-select-channel") do
        @workspace = Slack_cli::Workspace.new
      end
      # Override the gets method to test with a hard code user, insted of asking the user.
      def @workspace.gets
        "general"
      end
      @selected = @workspace.select_channel
    
      expect(@workspace.selected).must_be_instance_of Slack_cli::Channel
      expect(@workspace.selected.name).must_equal "general"
    end

    it "selected equals to nil when channel does not exist" do
      VCR.use_cassette("workspace-select-channel") do
        @workspace = Slack_cli::Workspace.new
      end
      # Override the gets method to test with a hard code user, insted of asking the user.
      def @workspace.gets
        "ChannelNil"
      end
      @selected = @workspace.select_channel
      
      assert_nil(@workspace.selected)
    end
    
    it "show_details - Based on the selected User/Channel" do
      VCR.use_cassette("workspace-select-channel") do
        @workspace = Slack_cli::Workspace.new
      end
      # Takes general but it work with user names too.
      def @workspace.gets
        "general"
      end
      @selected = @workspace.select_channel
      expect(@workspace.show_details).must_be_kind_of TablePrint::Returnable
      expect(@workspace.selected.name).must_equal "general"
    end

    it "send message - Based on the selected Channel" do
      VCR.use_cassette("workspace-select-channel") do
        @workspace = Slack_cli::Workspace.new

        def @workspace.gets
          "general"
        end
        
        @selected = @workspace.select_channel
        
        expect(@workspace.selected.send_message(@selected)).must_equal true
      end
   
    end

  end
end

