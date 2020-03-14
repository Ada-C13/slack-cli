require_relative "test_helper"
require_relative '../lib/user'

describe ".list_all" do
  it "provides instances of User class" do
    users = []
    VCR.use_cassette("users.list") do
      users = SlackCLI::User.list_all
    end
    
    expect(users.first).must_be_instance_of SlackCLI::User
    expect(users.last).must_be_instance_of SlackCLI::User
  end
end

describe "#details" do
  it "returns details about a User" do
    details = "\nThe slack user with username slackbot and Slack ID USLACKBOT is named Slackbot.\n"
    selected = nil
    VCR.use_cassette("users.list") do
      workspace = SlackCLI::Workspace.new
      selected = workspace.select_user('USLACKBOT')  
    end

    expect(selected).must_be_instance_of SlackCLI::User
    expect(selected.details).must_equal details
  end 
end