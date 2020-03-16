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
      expect(@test_workspace.channels.length).must_equal 3 # Assumption: This workspace will not have any more channels created 
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

  xdescribe "send_message" do 
    # TODO: write tests for this method
    # i could not get my bot to post messages 
  end 
  
end