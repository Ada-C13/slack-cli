require_relative 'test_helper'
require_relative "../lib/user" # so we inherit the error

describe 'instantiates a user' do
  
  it 'user object properties' do
    new_user = User.new('U0G9QF9C6', "SlackBot", "Slack Bot", "Worth My Salt", "🤡")
    
    expect(new_user).must_be_instance_of User
    expect(new_user.slack_id).must_equal 'U0G9QF9C6'
    expect(new_user.name).must_equal "SlackBot"
    expect(new_user.real_name).must_equal "Slack Bot"
    expect(new_user.status_text).must_equal "Worth My Salt"
    expect(new_user.status_emoji).must_equal "🤡"
  end
  
end


describe "User.get_everything" do
  it 'loads users' do
    VCR.use_cassette('load_users') do 
      all_users = User.get_everything("users.list")
      expect(all_users).must_be_kind_of HTTParty::Response
      expect(all_users["members"].length).must_be :>, 0
    end
  end
end


describe 'User.list_users' do
  it 'loads correct user info' do
    VCR.use_cassette('load_users') do 
      all_users = User.list_users
      test_user = all_users[0]
      expect(test_user.slack_id).must_equal "USLACKBOT"
      expect(test_user.name).must_equal "slackbot"
      expect(test_user.real_name).must_equal "Slackbot"
      expect(test_user.status_text).must_equal ""
      expect(test_user.status_emoji).must_be_empty
    end
  end
  
  it 'raises an error when a call fails' do
    VCR.use_cassette('load_users') do
      expect{ User.get_everything("bogus.endpoint") }.must_raise SlackAPIError
    end
  end
  
end


describe 'details' do
  before do 
    @user = User.new('U0G9QF9C6', "SlackBot", "Slack Bot", "Worth My Salt", "🤡")
  end
  
  it "displays details of selected recipient" do
    expect(@user.details).must_equal "Slack ID: U0G9QF9C6, Name: SlackBot, Real Name: Slack Bot, Status Text: Worth My Salt, Status Emoji: 🤡"
  end
end