require_relative 'test_helper'
require_relative '../lib/recipient'

describe "initialize" do 
  it "will create a recipient object" do 

    channel = Recipient.new("YYUW", "random")
    channel.must_be_instance_of Recipient

  end 
end 

