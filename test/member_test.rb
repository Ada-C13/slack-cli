require_relative 'test_helper'

describe "Member - Working Case" do
  # before do
  #   VCR.use_cassette("working_case") do
  #     @workspace = Workspace.new
  #   end
  # end

  # it 'list out all users' do
  #   expect(@workspace.users.first).must_be_kind_of Member
  #   expect(@workspace.users.first.name).must_include 'slackbot'
  #   expect(@workspace.users.length).must_equal 3 
  # end

  # it 'list out all users' do
  #   expect(@workspace.channels.first).must_be_kind_of Channel
  #   expect(@workspace.channels.first.name).must_include 'general'
  #   expect(@workspace.channels.length).must_equal 3 
  # end
end

describe "Slack API - Non-working Case" do
  it "will raise an excption if no token provided" do

  end

  # before do
  #   VCR.use_cassette("working_case") do
  #     @workspace = Workspace.new
  #   end
  # end

  # it 'list out all users' do
  #   expect(@workspace.users.first).must_be_kind_of Member
  #   expect(@workspace.users.first.name).must_include 'slackbot'
  #   expect(@workspace.users.length).must_equal 3 
  # end

  # it 'list out all users' do
  #   expect(@workspace.channels.first).must_be_kind_of Channel
  #   expect(@workspace.channels.first.name).must_include 'general'
  #   expect(@workspace.channels.length).must_equal 3 
  # end
end


  # user can exit out of program
  # after command "quit" is entered, unable to interact with interface anymore


  # Messages are sent from bot
