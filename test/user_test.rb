require_relative 'test_helper'
require_relative '../lib/user'

describe "initialize" do 
  it "will create a User object" do 
    user = UserRecipient.new("YYUW", "random", "random stuff is put here", 4, "another string")
    user.must_be_instance_of UserRecipient

  end 
end 

describe "class methods" do
  it "can find data" do
    VCR.use_cassette("user_data") do
      response = UserRecipient.list_all()
      expect(response).wont_be_nil
    end
  end

  it "can find the right user" do 
    VCR.use_cassette("user_data") do
      user = UserRecipient.find("USLACKBOT")
      user.status_text.must_equal ""
    end
  end 

  it "can print out the details of USER" do 
    VCR.use_cassette("user_data") do
      user= UserRecipient.find("USLACKBOT")
      string = user.details 
      string.must_be_instance_of String
    end
  end
end