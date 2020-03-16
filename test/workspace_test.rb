require_relative 'test_helper'
#require_relative '../lib/user'
#require_relative '../lib/channel'
require_relative '../lib/workspace'

describe SlackCli::Workspace do
  describe "Workspace" do
    before do
      #create an instance of a workspace
      VCR.use_cassette("workspace-details") do
        @test_workspace = SlackCli::Workspace.new()
      end
    end

    describe "Workspace Instantiation" do
      it "creates an instance of a workspace" do
        #expect a workspace to be workspace object
        expect(@test_workspace).must_be_kind_of SlackCli::Workspace
        assert_nil(@test_workspace.selected)
      end
    end #instance of workspace

    describe "valid_inputs_id_names method" do
      it "returns all valid ids and names based on user" do
        valid_inputs = @test_workspace.valid_inputs_id_names("user")
        user_array = valid_inputs.find_all { |user| user == "kate.d.mangubat" }
        expect(user_array[0]).must_equal "kate.d.mangubat"
        valid_inputs = @test_workspace.valid_inputs_id_names("blahblah")
        expect(valid_inputs.length).must_equal 0
      end

      it "returns all valid ids and names based on channel" do
        valid_inputs = @test_workspace.valid_inputs_id_names("channel")
        channels = valid_inputs.find_all { |channel| channel == "slack-api" }
        expect(channels[0]).must_equal "slack-api"
      end
    end

    describe "find_user method" do
      it "finds a user based on input by a user" do
        #find me: kate.d.mangubat (nominal test)
        found_user = @test_workspace.find_user("kate.d.mangubat")
        expect(found_user.name).must_equal "kate.d.mangubat"
        #doesn't find user (edge case)
        found_user = @test_workspace.find_user("blahblahhblah")
        assert_nil(found_user)
      end
    end

    describe "find_channel method" do
      it "finds a channel based on input by a user" do
         #find slack-api (nominal test)
         found_channel = @test_workspace.find_channel("slack-api")
         expect(found_channel.name).must_equal "slack-api"
         #doesn't find channel (edge case)
         found_channel = @test_workspace.find_channel("blahblahhblah")
         assert_nil(found_channel)
      end
    end

    describe "send_message method" do
      it "send message to user" do
        VCR.use_cassette("sendmessage-details") do
          #NOMINAL need to select a user
          found_user = @test_workspace.find_user("kate.d.mangubat")
          #save selectes user
          @test_workspace.selected = found_user
          #send message to my id: "UUUKJ03NX"
          #message  "so many testsssssss"
          response_code = @test_workspace.send_message("so many testssss")
          #returns response code which is set to nil
          expect(response_code).must_equal 200
          #EDGE CASE
          @test_workspace.selected = nil
          response_code = @test_workspace.send_message("so many testssss")
          expect(response_code).must_equal nil
        end
      end
      
      it "sends message to channel" do
        VCR.use_cassette("sendmessagechannel-details") do
          #need to select a channel
          found_channel = @test_workspace.find_channel("slack-api")
          #save selectes channel
          @test_workspace.selected = found_channel
          #send message to channel: "slack-api"
          #message  "so many testsssssss"
          response_code = @test_workspace.send_message("so many testssss")
          #returns response code which is set to nil
          expect(response_code).must_equal 200
        end
      end

    end #send message method


  end #class
end #module