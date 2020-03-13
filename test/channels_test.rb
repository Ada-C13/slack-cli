require_relative "test_helper"

describe "Can instanitate a Channel" do
  before do
    VCR.use_cassette("channel_list") do
      @channel= Channel.list_channels
    end
  end

  it "Initialize " do
  
    expect(@channel[0]).must_be_kind_of Channel
  end
end
