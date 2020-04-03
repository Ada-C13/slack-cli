require_relative "test_helper"
require_relative "../lib/workspace"
require 'table_print'


describe "Workspace instantiation" do
  it "creates an instance of Workspace" do
    VCR.use_cassette("Workspace initialized") do
      expect(Workspace.new).must_be_instance_of Workspace
    end
  end
end


describe "Show Details" do
  it "Will return a table print of details" do
    VCR.use_cassette("workspace-show-details") do
      workspace = Workspace.new
 
      new_user = workspace.select_user("USLACKBOT")

      expect(workspace.show_details).must_be_kind_of TablePrint::Returnable
    end
  end

  
  it "Will return a table print of details" do
    VCR.use_cassette("workspace-show-details") do
      workspace = Workspace.new
      new_channel = workspace.select_channel("random")

      expect(workspace.show_details).must_be_kind_of TablePrint::Returnable
    end 
  end
end


describe "Select a specific user" do
  
  it "Select a user" do
    VCR.use_cassette("workspace-select-User") do
      @workspace = Workspace.new
    end
    @selected = @workspace.select_user("habenup")
    expect(@workspace.selected).must_be_instance_of User

    @selected = @workspace.select_user("UUW7LV8TB")
    expect(@workspace.selected).must_be_instance_of User
   end

   it "If no user is found returns nil" do
    VCR.use_cassette("workspace-select-User") do
      @workspace = Workspace.new
    end

    @selected = @workspace.select_user("test")
    expect(@workspace.selected).must_be_nil
  end
end


describe "Select a specific channel" do
  
  it "Select a channel" do
    VCR.use_cassette("workspace-select-Channel") do
      @workspace = Workspace.new
    end
    @selected = @workspace.select_channel("random")
    expect(@workspace.selected).must_be_instance_of Channel

    @selected = @workspace.select_channel("CV6AN643F")
    expect(@workspace.selected).must_be_instance_of Channel
  end

  it "if no channel is found returns nil" do
    VCR.use_cassette("workspace-select-Channel") do
      @workspace = Workspace.new
    end

    @selected = @workspace.select_channel("test")
    expect(@workspace.selected).must_be_nil
  end
end


describe "Send Message" do

  it "returns true if the message is sent to user" do
    VCR.use_cassette("workspace-select-User") do
      workspace = Workspace.new
      workspace.select_user("habenup")
      expect(workspace.selected).must_be_instance_of User

      response = workspace.send_message("Test message")
      expect(response).must_equal true
    end
  end

  it "returs true if the message is sent to channel" do
    VCR.use_cassette("workspace-select-Channel") do
      workspace = Workspace.new

      workspace.select_channel("random")
      expect(workspace.selected).must_be_instance_of Channel

      response = workspace.send_message("Test message")
      expect(response).must_equal true
    end
  end

  it "returns nil if there is no user or channel selected" do 
    VCR.use_cassette("workspace-select-Channel") do
      workspace = Workspace.new

      response = workspace.send_message("Test message")
      expect(response).must_equal nil
    end 
  end
end

