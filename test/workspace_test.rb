require_relative 'test_helper'

describe "workspace" do
  describe "initialize" do
    it "instantiates a Workspace class instance" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = Workspace.new
        expect(test_space).must_be_instance_of Workspace
        expect(test_space.users).must_be_instance_of Array
        expect(test_space.channels).must_be_instance_of Array
      end
    end

    it "stores all the users in an array under @users" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = Workspace.new
        puts test_space.users.length
        expect(test_space.users.length).wont_equal 0
        test_space.users.each do |user|
          expect(user).must_be_instance_of User
        end
      end
    end

    it "stores all the channels in an array under @channels" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = Workspace.new
        puts test_space.channels.length
        expect(test_space.channels.length).wont_equal 0
        test_space.channels.each do |channel|
          expect(channel).must_be_instance_of Channel
        end
      end
    end
  end

  describe "select_user" do
    it "returns the instance variable @selected" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = Workspace.new
        expect(test_space.select_user(id: "bogus")).must_be_nil
        expect(test_space.select_user(id: "USLACKBOT")).must_equal test_space.selected
        expect(test_space.select_user(username: "slackbot")).must_equal test_space.selected
      end
    end

    it "raises an ArgumentError if neither the Slack ID or name is passed in" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = Workspace.new
        expect{test_space.select_user()}.must_raise ArgumentError
      end
    end
  end

  describe "select_channel" do
    it "returns the instance variable @selected" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = Workspace.new
        expect(test_space.select_channel(id: "bogus")).must_be_nil
        expect(test_space.select_channel(name: "general")).must_equal test_space.selected
      end
    end

    it "raises an ArgumentError if neither the Slack ID or name is passed in" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = Workspace.new
        expect{test_space.select_channel()}.must_raise ArgumentError
      end
    end
  end

  describe "#list_users" do
    it "can list all the users from @users" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = Workspace.new
        response = test_space.list_users
        expect(response).must_equal true
      end
    end

    # it "will raise an exception when the recipient name or id is invalid" do
    #   VCR.use_cassette("workspace_endpoint") do
    #     test_space = Workspace.new
    #     expect {test_space.list_users}.must_raise SlackAPIError
    #   end
    # end
  end

  describe "#list_channels" do
    it "can list all the channels from @channels" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = Workspace.new
        response = test_space.list_channels
        expect(response).must_equal true
      end
    end

    # it "will raise an exception when the recipient name or id is invalid" do
    #   VCR.use_cassette("workspace_endpoint") do
    #     test_space = Workspace.new
    #     expect {test_space.list_channels}.must_raise SlackAPIError
    #   end
    # end
  end
end