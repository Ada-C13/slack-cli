require_relative 'test_helper'

describe "send_message" do
  it "send a valid message" do 
    VCR.use_cassette("list-user-endpoint") do
      recipient = Recipient.new(slack_id: "CV649DWUV", name: "slack-api")
      response = recipient.send_message("Hello from Lak")
      expect(response).must_equal true
    end
  end

  it "raise SlackAPIError when the slack_id is not valid" do 
    VCR.use_cassette("list-user-endpoint") do
      recipient = Recipient.new(slack_id: "CV6ZZ", name: "slack-api")
      expect{recipient.send_message("Hi....")}.must_raise SlackAPIError
    end
  end

  it "raise SlackAPIError when the message text is empty" do 
    VCR.use_cassette("list-user-endpoint") do
      recipient = Recipient.new(slack_id: "CV649DWUV", name: "slack-api")
      expect{recipient.send_message("")}.must_raise SlackAPIError
    end
  end
end