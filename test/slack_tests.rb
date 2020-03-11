require_relative 'test_helper'

describe "Slack API" do
  before do
    VCR.use_cassette("working_case") do
      @workspace = Workspace.new
    end
  end

  it 'list out all users' do
    expect(@workspace.users.first).must_be_kind_of Member
    expect(@workspace.users.first.name).must_include 'slackbot'
    expect(@workspace.users.length).must_equal 3 
  end

  it 'list out all users' do
    expect(@workspace.channels.first).must_be_kind_of Channel
    expect(@workspace.channels.first.name).must_include 'general'
    expect(@workspace.channels.length).must_equal 3 
  end
end


  # list out all users 
  # first user should be XXX
  # last user should be XXX
  # OR users should include... list of names
  # number of user should be X
  
  # list out all channels
  # first channels should be XXX
  # last channels should be XXX
  # OR channels should include... list of channels
  # number of channels should be

  # user can exit out of program
  # after command "quit" is entered, unable to interact with interface anymore


  # Messages are sent from bot
