require_relative 'test_helper'
require_relative '../lib/channel'

describe "initialize" do 
  it "will create a Channel object" do 

    channel = ChannelRecipient.new("YYUW", "random", "random stuff is put here", 4)
    channel.must_be_instance_of ChannelRecipient

  end 
end 

describe "class methods" do
  it "can find data" do
    VCR.use_cassette("channel_data") do
      response = ChannelRecipient.list_all()
      expect(response).wont_be_nil
    end
  end




  # it "all" do
  #   VCR.use_cassette("location_find") do
  #     location = ""
  #     expect {
  #       response = get_location(location)
  #     }.must_raise SearchError
  #   end
  # end
  #expect(response["Seattle"][:lon]).must_equal "-122.3300624"
      #expect(response["Seattle"][:lat]).must_equal "47.6038321"
end