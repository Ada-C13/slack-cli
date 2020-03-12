require_relative 'test_helper'

describe 'initialize' do
  before do
    
  end
  it 'instantiates a recipient' do
    recipient = Recipient.new(123456, "LeahBot")
    expect(recipient).must_be_instance_of Recipient
    expect(recipient.name).must_equal "LeahBot"
    expect(recipient.slack_id).must_equal 123456
  end
  

  # it 'validates the id' do
  #   slack_id = -1
  #   expect{ Recipient.new(slack_id, "LeahBot") }.must_raise ArgumentError
  # end


  # it 'validates name' do
  #   name = 0
  #   expect{ Recipient.new(123456, name) }.must_raise ArgumentError
  # end

end 