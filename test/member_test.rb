require_relative 'test_helper'

describe "User Access - Working Case" do
  before do
    VCR.use_cassette("list_users") do
      @users = Member.all
    end
  end

  it 'inherits name and id from recipient' do
    expect(@users.first.name).must_equal'slackbot'
    expect(@users.first.id).must_equal 'USLACKBOT' 
  end

  it 'list out all users' do
    expect(@users.first).must_be_kind_of Member
    expect(@users.length).must_equal 3 
    expect(@users.first.real_name).must_equal 'Slackbot' 
  end

end
