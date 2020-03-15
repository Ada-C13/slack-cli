require_relative "test_helper"
require_relative '../lib/user'

describe "#initialize" do
  it "returns a specific instance of a User" do
    user = nil
    VCR.use_cassette("chat.postMessage") do
      data = {'id' => '1234',
        'name' => 'bot',
        'real_name' => 'testbot',
        'profile' => {'status_text' => 'test text',
        'status_emoji' => ':test:'}}
  
      user = SlackCLI::User.new(data)
      SlackCLI::Workspace.new
    end
    expect(user).must_be_instance_of SlackCLI::User
    expect(user.slack_id).must_equal '1234'
    expect(user.name).must_equal 'bot'
    expect(user.real_name).must_equal 'testbot'
    expect(user.status_text).must_equal 'test text'
    expect(user.status_emoji).must_equal ':test:'
  end
end

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
    details = "\nThe slack user with username slackbot and Slack ID USLACKBOT is named Slackbot. "
    selected = nil
    VCR.use_cassette("users.list") do
      workspace = SlackCLI::Workspace.new
      selected = workspace.select_user('USLACKBOT')  
    end

    expect(selected).must_be_instance_of SlackCLI::User
    expect(selected.details).must_equal details
  end

  it "outputs details with text status and emoji" do
    details = "\nThe slack user with username bot and Slack ID 1234 is named testbot. Their status is 'test text' and their status emoji is :test:."
    user = nil
    VCR.use_cassette("users.list") do
      data = {'id' => '1234',
        'name' => 'bot',
        'real_name' => 'testbot',
        'profile' => {'status_text' => 'test text',
        'status_emoji' => ':test:'}}
      user = SlackCLI::User.new(data)
      SlackCLI::Workspace.new
    end
    expect(user.details).must_equal details
  end 
end