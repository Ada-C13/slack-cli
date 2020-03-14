require_relative 'test_helper'
require_relative '../lib/recipient'


describe "recipient" do
  USERS_URI = "https://slack.com/api/users.list"
  SLACK_TOKEN = ENV["SLACK_TOKEN"]

  describe "#send_message" do
    it "can send a valid message" do
      VCR.use_cassette("chat_post_endpoint") do
        recipient01 = SlackCLI::Recipient.new("USLACKBOT")
        response = recipient01.send_message("Can I do this? I can do this!")
        expect(response).must_equal true
      end
    end
  
    it "will raise an exception when the recipient name or id is invalid" do
      VCR.use_cassette("chat_post_endpoint") do
        recipient01 = SlackCLI::Recipient.new("bogus")
        expect {recipient01.send_message("Let's get an error")}.must_raise SlackCLI::SlackAPIError
      end
    end

    it "will raise an exception when missing the correct arguments" do
      VCR.use_cassette("chat_post_endpoint") do
        recipient02 = SlackCLI::Recipient.new("USLACKBOT")
        expect {recipient02.send_message()}.must_raise ArgumentError
      end
    end
  end

  describe "#get_details" do
    it "is an abstract method that needs to be implemented by subclasses" do
      new_recipient = SlackCLI::Recipient.new("TESTID001", "test_recipient")
      expect{new_recipient.get_details}.must_raise NotImplementedError
    end
  end

  describe "self.list_all" do
    it "is an abstract method that needs to be implemented by subclasses" do
      expect{SlackCLI::Recipient.list_all}.must_raise NotImplementedError
    end
  end
end
