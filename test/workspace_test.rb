require_relative "test_helper"
require_relative '../lib/workspace'

describe "#initialize" do
  it "returns an object of Workspace class" do
    workspace = nil
    VCR.use_cassette("workspace") do
      workspace = SlackCLI::Workspace.new
    end
    expect(workspace).must_be_instance_of SlackCLI::Workspace
  end
end

describe "#select_user" do
  it "returns a selected user object" do
    workspace = nil
    VCR.use_cassette("users.list") do
      workspace = SlackCLI::Workspace.new
    end
    user = workspace.select_user('USLACKBOT')
    expect(user).must_be_instance_of SlackCLI::User 
  end

  it "returns nil if user input is invalid" do
    workspace = nil
    VCR.use_cassette("users.list") do
      workspace = SlackCLI::Workspace.new
    end
    expect(workspace.select_user('Maria')).must_be_nil
  end
end

describe "#select_channel" do
  it "returns a selected channel object" do
    workspace = nil
    VCR.use_cassette("chanels.list") do
      workspace = SlackCLI::Workspace.new
    end
    channel = workspace.select_channel('random')
    expect(channel).must_be_instance_of SlackCLI::Channel 
  end

  it "returns nil if channel input is invalid" do
    workspace = nil
    VCR.use_cassette("chanels.list") do
      workspace = SlackCLI::Workspace.new
    end
    expect(workspace.select_channel('Maria')).must_be_nil
  end
end

describe "#show_details" do
  it "returns a text with details" do
    workspace = nil
    VCR.use_cassette("chanels.list") do
      workspace = SlackCLI::Workspace.new
      channel = workspace.select_channel('random')
    end
    expect(workspace.show_details).must_be_instance_of String 
  end
end

describe "#send_message" do
  it "returns true when message is sent" do
    sending_message = nil
    VCR.use_cassette("chat.postMessage") do
      workspace = SlackCLI::Workspace.new
      user = workspace.select_user('USLACKBOT')
      sending_message = workspace.send_message('Test')
    end
    expect(sending_message).must_equal true 
  end
end

