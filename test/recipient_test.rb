require_relative 'test_helper'
require "./lib/recipient"

describe "Recipient" do
  before do 
    slack_id = "abcdefg123"
    name = "Jessica"
    @recipient = Recipient.new(slack_id, name)
  end

  it "can create a Recipient class" do
    expect(@recipient).must_be_kind_of Recipient
  end
end
