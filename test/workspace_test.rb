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

  describe "find_recipient" do
    it "returns the recipient found" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = Workspace.new
        expect(test_space.find_recipient("USLACKBOT")).must_be_instance_of User
        expect(test_space.find_recipient("slackbot")).must_be_instance_of User
        expect(test_space.find_recipient("general")).must_be_instance_of Channel
        expect(test_space.find_recipient("random")).must_be_instance_of Channel
      end
    end

    it "raises an ArgumentError if no or invalid Slack ID or name is passed in" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = Workspace.new
        expect{test_space.find_recipient()}.must_raise ArgumentError
        expect{test_space.find_recipient("bogusbogustestbogus")}.must_raise ArgumentError
      end
    end
  end

  describe "#send_message" do
    it "will raise an ArgumentError when there is no selected recipient" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = Workspace.new
        expect{test_space.send_message}.must_raise ArgumentError
      end
    end
  end 

  describe "#show_details" do
    it "can show the details of the user" do
      VCR.use_cassette("workspace_endpoint") do
        test_space = Workspace.new
        user01 = test_space.users[0]
        test_space.selected = user01
        response = test_space.show_details
        expect(response).must_equal true
      end
    end
  end
end
  # describe "select_user" do
  #   it "returns the instance variable @selected" do
  #     VCR.use_cassette("workspace_endpoint") do
  #       test_space = Workspace.new
  #       expect(test_space.select_user("USLACKBOT")).must_equal test_space.selected
  #       expect(test_space.select_user("slackbot")).must_equal test_space.selected
  #     end
  #   end

  #   it "raises an ArgumentError if no or invalid Slack ID or name is passed in" do
  #     VCR.use_cassette("workspace_endpoint") do
  #       test_space = Workspace.new
  #       expect{test_space.select_user()}.must_raise ArgumentError
  #       expect{test_space.select_user("bogus")}.must_raise ArgumentError
  #     end
  #   end
  # end

  # describe "select_channel" do
  #   it "returns the instance variable @selected" do
  #     VCR.use_cassette("workspace_endpoint") do
  #       test_space = Workspace.new
  #       expect(test_space.select_channel("general")).must_equal test_space.selected
  #       expect(test_space.select_channel("random")).must_equal test_space.selected
  #     end
  #   end

  #   it "raises an ArgumentError if no or invalid Slack ID or name is passed in" do
  #     VCR.use_cassette("workspace_endpoint") do
  #       test_space = Workspace.new
  #       expect{test_space.select_channel()}.must_raise ArgumentError
  #       expect{test_space.select_channel("thisbogusidshouldraiseerror")}.must_raise ArgumentError
  #     end
  #   end
  # end

  # describe "#list_users" do
  #   it "can list all the users from @users" do
  #     VCR.use_cassette("workspace_endpoint") do
  #       test_space = Workspace.new
  #       response = test_space.list_users
  #       expect(response).must_equal true
  #     end
  #   end
  # end

  # describe "#list_channels" do
  #   it "can list all the channels from @channels" do
  #     VCR.use_cassette("workspace_endpoint") do
  #       test_space = Workspace.new
  #       response = test_space.list_channels
  #       expect(response).must_equal true
  #     end
  #   end
  # end
