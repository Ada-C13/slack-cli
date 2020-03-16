require_relative "test_helper"
describe "channel initializes" do

  it "channel initializes with arguments" do
    recipient = Channel.new(1, "Ada", 3, "general")
  
      expect(recipient).must_be_instance_of Channel
      expect(recipient.name).must_equal "Ada"
      expect(recipient.id).must_equal 1
      expect(recipient.num_members).must_equal 3
      expect(recipient.topic).must_equal "general"
  end  
    
  it "user raises error with not enough arguments" do
    
    expect{Channel.new()}.must_raise ArgumentError
    expect{Channel.new(1)}.must_raise ArgumentError
    expect{Channel.new(nil,nil,nil,nil)}.must_raise ArgumentError
    expect{Channel.new(1,nil,3)}.must_raise ArgumentError
    expect{Channel.new(1,"ada")}.must_raise ArgumentError
    expect{Channel.new(nil,"ada")}.must_raise ArgumentError
  end  

end