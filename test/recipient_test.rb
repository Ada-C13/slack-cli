require_relative 'test_helper.rb'

describe "Recipient" do
  it "can initialize Recipient with slack id" do
    slack_id = "UUT7ESHPU"
    new_recipient = Recipient.new(slack_id)
    expect(new_recipient).must_be_kind_of Recipient
    expect(new_recipient.slack_id).must_equal slack_id
  end

end