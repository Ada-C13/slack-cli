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

  it "can find the right channel" do 
    VCR.use_cassette("channel_data") do
      channel = ChannelRecipient.find("CUUG9HF6X")
      channel.name.must_equal "general"
    end
  end 

  it "can print out the details" do 
    VCR.use_cassette("channel_data") do
      channel = ChannelRecipient.find("CUUG9HF6X")
      string = channel.details 
      string.must_be_instance_of String
    end
  end
end