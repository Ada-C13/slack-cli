require_relative "test_helper"
require_relative "../lib/workspace"

describe "Workspace" do
  before do 
    VCR.use_cassette("workspace-test") do 
      @test_workspace = Workspace.new()
    end 
  end 

  describe "initialize" do 
    it "creates an instance of a Workspace object" do 
      expect(@test_workspace).must_be_kind_of Workspace
    end 

    it "creates an array of User objects" do 
      expect(@test_workspace.users).must_be_kind_of Array
      expect(@test_workspace.users.length).must_equal 11 # Assumption: This workspace will not have any more users created      
    end 

    it "creates an array of Channel objects" do 
      expect(@test_workspace.channels).must_be_kind_of Array
    end 
  end

  describe "select_user(requested_user)" do 
    before do 
      VCR.use_cassette("workspace-test") do 
        @test_workspace = Workspace.new()
      end 
    end 

    it "returns user's name associated with requested username" do 
      requested_user = "yesentorres"
      associated_user = @test_workspace.users.find { |user| user.name == requested_user }
      output = @test_workspace.select_user(requested_user)
      expect(output).must_equal "User \"#{associated_user.real_name}\" has been selected."
    end

    it "returns user's name associated with requested user slack id" do 
      requested_user= "UUTK13WE6"
      associated_user = @test_workspace.users.find { |user| user.slack_id == requested_user }
      output = @test_workspace.select_user(requested_user)
      expect(output).must_equal "User \"#{associated_user.real_name}\" has been selected."
    end

    it "returns a message if no user is found" do
      requested_user = "doesnotexist"
      output = @test_workspace.select_user(requested_user)
      expect(output).must_equal "Sorry, user \"#{requested_user}\" does not exist in this workspace."
    end 
  end 

  describe "select_channel(requested_channel)" do 
    before do 
      VCR.use_cassette("workspace-test") do 
        @test_workspace = Workspace.new()
      end 
    end 

    it "returns channel name that matches requested channel name" do 
      requested_channel = "general"
      output = @test_workspace.select_channel(requested_channel)
      expect(output).must_equal "Channel titled \"#{requested_channel}\" has been selected."
    end

    it "returns channel name associated with requested channel slack id" do 
      requested_channel = "CUTE4M96W"
      associated_channel = @test_workspace.channels.find { |channel| channel.slack_id == requested_channel }
      output = @test_workspace.select_channel(requested_channel)
      expect(output).must_equal "Channel titled \"#{associated_channel.name}\" has been selected."
    end

    it "returns a message if no channel name is found" do
      requested_channel = "doesnotexist"
      output = @test_workspace.select_channel(requested_channel)
      expect(output).must_equal "Sorry, channel \"#{requested_channel}\" does not exist in this workspace."
    end 
  end 

  xdescribe "display_details" do 
    # TODO: write tests for this method
    # i was unsure how to verify command line output
  end 

  describe "send_message" do 
    it "can send a valid message" do 
      # arrange
      VCR.use_cassette("workspace-test") do 
        @test_workspace = Workspace.new()
        @test_workspace.select_channel("general")
        @selected_channel = @test_workspace.selected 
      end 
      result = {}

      # act 
      VCR.use_cassette("post-messages") do 
        result = @selected_channel.send_message("Hey I can post messages!")
      end 

      # assert
      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end 

    it "raises an error if no recipient is selected" do 
      # arrange
      @selected_channel = Channel.new(topic: "channel does not exist", member_count: 1, name: "bogus", slack_id:"CHAT1234")

      # act / assert 
      result = {}
      VCR.use_cassette("post-messages") do 
        expect {@selected_channel.send_message("Hey I can post messages!")}.must_raise SlackAPIError
      end 
    end

    it "sends the correct message to the correct channel" do 
      # arrange
      VCR.use_cassette("workspace-test") do 
        @test_workspace = Workspace.new()
        @test_workspace.select_channel("CUTE4MTD0") # "api-testing"
        @selected_channel = @test_workspace.selected 
      end 
      result = {}

      # act 
      VCR.use_cassette("post-messages") do 
        result = @selected_channel.send_message("heeeey everyone! :)")
      end 

      # assert
      expect(result["channel"]).must_equal "CUTE4MTD0"    
      expect(result["message"]["text"]).must_equal "heeeey everyone! :)"
    end
  end 
end