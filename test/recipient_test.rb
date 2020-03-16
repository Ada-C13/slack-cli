require_relative 'test_helper'

describe "Recipient class" do
  describe "send_message" do
    it "raises an exception if there is an error in sending message" do
      VCR.use_cassette("recipient-raise-exception") do
        recipient = Recipient.new(slack_id: "USLACKBOT", name: "slackbot")
        message = "hello"
        send_to = "assd"
        expect{recipient.send_message(message: message, send_to: send_to)}.must_raise SlackApiError
      end
    end
  end
end