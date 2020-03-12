require_relative 'test_helper'

describe "Workspace Access - Working Case" do
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
