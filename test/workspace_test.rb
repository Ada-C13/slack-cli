require_relative 'test_helper'
require_relative '../lib/workspace.rb'

describe "Workspace" do
  before do
    VCR.use_cassette("users-list-endpoint") do
      VCR.use_cassette("channels-list-endpoint") do
        @workspace = Workspace.new
      end
    end
  end

  describe "Workspace instantiation" do
    it "is an instance of Workspace" do
      expect(@workspace).must_be_kind_of Workspace
    end 

    it "is set up for specific attributes" do
      expect(@workspace.channels).must_be_kind_of Array
      expect(@workspace.users).must_be_kind_of Array
    end

    it "has default status of nil for selected" do
      expect(@workspace.selected).must_equal nil
    end
  end

  describe "select_user" do
    it "correctly selects a user by username" do
      def @workspace.get_user_input; "slackbot" end
      expect(@workspace.select_user).must_equal "slackbot has been selected"
    end

    it "correctly selects a user by slack_id" do
      def @workspace.get_user_input; "USLACKBOT" end
      expect(@workspace.select_user).must_equal "slackbot has been selected"
    end

    it "provides a message if a user could not be found" do
      def @workspace.get_user_input; "notauser" end
      expect(@workspace.select_user).must_equal "User could not be found."
    end
  end

  describe "select_channel" do
    it "correctly selects a channel by channel name" do
      def @workspace.get_user_input; "random" end
      expect(@workspace.select_channel).must_equal "random has been selected"
    end
    
    it "correctly selects a channel by slack_id" do
      def @workspace.get_user_input; "CV7V4KYLF" end
      expect(@workspace.select_channel).must_equal "random has been selected"
    end

    it "provides a message if a channel could not be found" do
      def @workspace.get_user_input; "notachannel" end
      expect(@workspace.select_channel).must_equal "Channel could not be found."
    end
  end

  describe "show_details" do
    
  end
end
