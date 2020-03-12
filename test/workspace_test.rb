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

  it 'properly selects the user' do
    recipient = @workspace.select_recipient('slackbot')

    expect(recipient).must_be_kind_of Member
    expect(recipient.id).must_equal 'USLACKBOT'
  end

  it 'properly selects the channel' do
    recipient = @workspace.select_recipient('general')

    expect(recipient).must_be_kind_of Channel
    expect(recipient.id).must_equal 'CUVFN5GQ1'
  end

  it 'raises argument error if user does not exist' do
    recipient = @workspace.select_recipient('evilbot')

    expect(recipient).must_be_nil
  end

  it 'raises argument error if channel does not exist' do
    recipient = @workspace.select_recipient('evil_channel')
    
    expect(recipient).must_be_nil
  end
end
