require_relative "test_helper"

describe "recipient channel factory self.create" do

  it "self.create works with CHANNEL name" do
    recipient = Channel.create("general", "channel_name")
  
      expect(recipient).must_be_instance_of Channel
      expect(recipient.name).must_equal "general"
  end  
    

  it "self.create works with CHANNEL id" do
    recipient = Channel.create("A100", "channel_id")
  
      expect(recipient).must_be_instance_of Channel
      expect(recipient.id).must_equal "A100"
  end  
  
end