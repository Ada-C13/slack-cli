require_relative 'test_helper'
require_relative '../lib/workspace'


describe "workspace" do
  describe "initialize" do
    it "instantiates a Workspace class instance" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = SlackCLI::Workspace.new
        expect(test_space).must_be_instance_of SlackCLI::Workspace
        expect(test_space.users).must_be_instance_of Array
        expect(test_space.channels).must_be_instance_of Array
      end
    end

    it "stores all the users in an array under @users" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = SlackCLI::Workspace.new
        expect(test_space.users.length).wont_equal 0
        test_space.users.each do |user|
          expect(user).must_be_instance_of SlackCLI::User
        end
      end
    end

    it "stores all the channels in an array under @channels" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = SlackCLI::Workspace.new
        expect(test_space.channels.length).wont_equal 0
        test_space.channels.each do |channel|
          expect(channel).must_be_instance_of SlackCLI::Channel
        end
      end
    end
  end

  describe "find_recipient" do
    it "returns the recipient found" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = SlackCLI::Workspace.new
        expect(test_space.find_recipient("USLACKBOT")).must_be_instance_of SlackCLI::User
        expect(test_space.find_recipient("slackbot")).must_be_instance_of SlackCLI::User
        expect(test_space.find_recipient("general")).must_be_instance_of SlackCLI::Channel
        expect(test_space.find_recipient("random")).must_be_instance_of SlackCLI::Channel
      end
    end

    it "raises an ArgumentError if no or invalid Slack ID or name is passed in" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = SlackCLI::Workspace.new
        expect{test_space.find_recipient()}.must_raise ArgumentError
        expect{test_space.find_recipient("bogusbogustestbogus")}.must_raise ArgumentError
      end
    end
  end

  describe "#send_message" do   #other send_message tests in Recipient
    it "will raise an ArgumentError when there is no selected recipient" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = SlackCLI::Workspace.new
        expect{test_space.send_message}.must_raise ArgumentError
      end
    end
  end 

  describe "#show_details" do
    it "can show the details of the user" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = SlackCLI::Workspace.new
        user01 = test_space.users[0]
        test_space.assign_selected(user01)
        response = test_space.show_details
        expect(response).must_equal true
      end
    end

    it "will raise an ArgumentError when there is no selected recipient" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = SlackCLI::Workspace.new
        expect{test_space.send_message}.must_raise ArgumentError
      end
    end
  end

  describe "#show_history" do
    it "can show the conversations history of the selected recipient" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = SlackCLI::Workspace.new
        user01 = test_space.find_recipient("general")
        test_space.assign_selected(user01)
        response = test_space.show_history
        expect(response).must_be_instance_of Array
      end
    end

    it "will raise an ArgumentError when there is no selected recipient" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = SlackCLI::Workspace.new
        expect{test_space.show_history}.must_raise ArgumentError
      end
    end
  end

  describe "#assign_selected" do
    it "can assign a recipient instance to @selected" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = SlackCLI::Workspace.new
        recipient01 = test_space.find_recipient("USLACKBOT")
        expect(test_space.assign_selected(recipient01)).must_equal test_space.selected
        recipient02 = test_space.find_recipient("random")
        expect(test_space.assign_selected(recipient02)).must_equal test_space.selected
      end
    end
  end
end
