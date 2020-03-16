require_relative "test_helper"

describe "user initializes" do

  it "user initializes with name" do
    recipient = User.new(1, "Ada", "AdaLove")
  
      expect(recipient).must_be_instance_of User
      expect(recipient.name).must_equal "Ada"
      expect(recipient.id).must_equal 1
      expect(recipient.real_name).must_equal "AdaLove"
  end  
    
  it "user raises error with not enough arguments" do
    
    expect{User.new()}.must_raise ArgumentError
    expect{User.new(1)}.must_raise ArgumentError
    expect{User.new(nil,nil,nil)}.must_raise ArgumentError
    expect{User.new(1,nil,"ada")}.must_raise ArgumentError
    expect{User.new(1,"ada")}.must_raise ArgumentError
    expect{User.new(nil,"ada")}.must_raise ArgumentError
  end  

end
