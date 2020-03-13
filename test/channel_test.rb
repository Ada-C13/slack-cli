require_relative 'test_helper'

describe "Channel Access - Working Case" do
  before do
    VCR.use_cassette("list_channels") do
      @channels = Channel.all
    end
  end

  it 'inherits name and id from recipient' do
    expect(@channels.first.name).must_equal 'general'
    expect(@channels.first.id).must_equal 'CUVFN5GQ1' 
  end

  it 'list out all channels' do
    expect(@channels.first).must_be_kind_of Channel
    expect(@channels.length).must_equal 3 
    expect(@channels.first.topic).must_equal "Company-wide announcements and work-based matters"
    expect(@channels.first.member_count).must_equal 1
  end

end