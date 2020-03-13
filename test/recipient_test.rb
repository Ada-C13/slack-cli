require_relative 'test_helper'

describe 'initialize' do
  before do
    
  end
  it 'instantiates a recipient' do
    recipient = Recipient.new('U0G9QF9C6', "SlackBot")
    expect(recipient).must_be_instance_of Recipient
    expect(recipient.slack_id).must_equal 'U0G9QF9C6'
    expect(recipient.name).must_equal "SlackBot"
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

describe 'details' do
  before do 
    @recipient = Recipient.new('U0G9QF9C6', "SlackBot")
  end
  
  it "displays details of selected recipient" do
    expect(@recipient.details).must_equal "U0G9QF9C6, SlackBot,"
  end
end