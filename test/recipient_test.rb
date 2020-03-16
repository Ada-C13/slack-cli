require_relative "test_helper"

require 'httparty'

describe "initialize" do

  it "initializes" do
    recipient = Recipient.new(1, "Ada")
  
      expect(recipient).must_be_instance_of Recipient
      expect(recipient.name).must_equal "Ada"
      expect(recipient.id).must_equal 1
  end  

  it "initializes with some arguments" do
    recipient = Recipient.new(id = nil, name = "Ada")
    recipient2 = Recipient.new(id = 100, name = nil)
    recipient3 = Recipient.new(id = nil, name = nil)

      expect(recipient).must_be_instance_of Recipient
      expect(recipient.name).must_equal "Ada"
      expect(recipient.id).must_equal nil

      expect(recipient2).must_be_instance_of Recipient
      expect(recipient2.id).must_equal 100
      expect(recipient2.name).must_equal nil

      expect(recipient3).must_be_instance_of Recipient
      expect(recipient3.id).must_equal nil
      expect(recipient3.name).must_equal nil
      
  end  
end



# Ughhhhhh I don't know, My IQ lowered this week! I'm going to sleep.
# describe "send_message" do
#   it "can send a valid message" do
#     VCR.use_cassette("slack-posts") do
#       response = Recipient.send_message("Hey I can post messages!", "UV85Q5X6K")
#       expect(response).must_equal true
#     end
#   end
# end







