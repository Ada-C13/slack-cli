require_relative "test_helper"
require_relative '../lib/slack'

describe "it provides channels details" do
  it "can find one channel" do
    channel = "general"
    response = []
    VCR.use_cassette("channels") do
      response = get_channels
    end
    
    expect(response.first).must_equal channel
  end 
end