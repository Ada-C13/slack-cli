require_relative 'test_helper'

describe 'initialize' do
  it 'instantiates a recipient' do
    recipient = Recipient.new('U0G9QF9C6', "SlackBot")
    expect(recipient).must_be_instance_of Recipient
    expect(recipient.slack_id).must_equal 'U0G9QF9C6'
    expect(recipient.name).must_equal "SlackBot"
  end
end