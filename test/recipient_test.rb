require_relative "test_helper"

require 'httparty'

describe "initialize" do

  it "initializes with no arguments" do
    recipient = Recipient.new
  
      expect(recipient).must_be_instance_of Recipient
      expect(recipient.name).must_equal nil
      expect(recipient.id).must_equal nil
  end  

  it "initializes with some arguments" do
    recipient = Recipient.new(name = "Ada", id = nil)
    recipient2 = Recipient.new(name = nil, id = 100)
    recipient3 = Recipient.new(name = nil, id = nil)

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


