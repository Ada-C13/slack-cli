require_relative "test_helper"

require 'httparty'

describe "initialize" do

  it "initializes with no arguments" do
    recipient = Recipient.new
  
      expect(recipient).must_be_instance_of Recipient
      expect(recipient.user_name).must_equal nil
  end  

  it "initializes with some arguments" do
    recipient = Recipient.new(user_name = "Ada", user_id = nil, channel_name = "Ada's Channel", channel_id = nil)
    recipient2 = Recipient.new(user_name = nil, user_id = 100, channel_name = nil, channel_id = 200)
    recipient3 = Recipient.new(user_name = nil, user_id = nil, channel_name = nil, channel_id = "test")

      expect(recipient).must_be_instance_of Recipient
      expect(recipient.user_name).must_equal "Ada"
      expect(recipient.channel_name).must_equal "Ada's Channel"

      expect(recipient2).must_be_instance_of Recipient
      expect(recipient2.user_id).must_equal 100
      expect(recipient2.channel_id).must_equal 200

      expect(recipient3).must_be_instance_of Recipient
      expect(recipient3.user_id).must_equal nil
      expect(recipient3.user_name).must_equal nil
      expect(recipient3.channel_id).must_equal "test"
  end  
end

describe "recipient factories" do

  it "self.create_recipient_from_name creates recipient with USER name" do
    recipient = Recipient.create_recipient_from_name("Ada", "user")
  
      expect(recipient).must_be_instance_of Recipient
      expect(recipient.user_name).must_equal "Ada"
  end  
  
  it "self.create_recipient_from_name creates recipient with CHANNEL name" do
    recipient = Recipient.create_recipient_from_name("general", "channel")
  
      expect(recipient).must_be_instance_of Recipient
      expect(recipient.channel_name).must_equal "general"

  end   

  it "create_recipient_from_ID creates recipient with USER id" do
    recipient = Recipient.create_recipient_from_id("A100", "user")
  
      expect(recipient).must_be_instance_of Recipient
      expect(recipient.user_id).must_equal "A100"
  end  
  
  it "create_recipient_from_name creates recipient with CHANNEL ID" do
    recipient = Recipient.create_recipient_from_id("A100", "channel")
  
      expect(recipient).must_be_instance_of Recipient
      expect(recipient.channel_id).must_equal "A100"

  end   
   
end
