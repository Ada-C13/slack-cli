require_relative "test_helper"
require_relative '../lib/recipient'

describe "Recipient" do
  before do
    @new_recipient = Recipient.new(slack_id: "C01050CDZC6", name: "name")
  end

  it "initializes recipient with name and slack_id" do
    expect(@new_recipient).must_be_kind_of Recipient
    expect(@new_recipient.name).must_equal "name"
    expect(@new_recipient.slack_id).must_equal "C01050CDZC6"
  end

  describe "send method" do
    it "sends a slack message" do
      response = nil
      message = "hello"

      VCR.use_cassette("send") do
        response = @new_recipient.send(message)
      end
      
      expect(response).must_be_kind_of HTTParty::Response
      expect(response["ok"]).must_equal true
      expect(response["channel"]).must_equal "C01050CDZC6"
      expect(response["message"]["text"]).must_equal message
    end
  end
end