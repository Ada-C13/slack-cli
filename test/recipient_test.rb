require_relative 'test_helper'
require_relative '../lib/recipient'

describe "Recipient" do
  describe "send_message" do
    it "can send a message" do
      result = {}

      # make an API call
      VCR.use_cassette("recipients-list-endpoint") do
          # call method you intend to use
          result = Recipient.send_message("hi")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true

    end

    it "raises an error when a call fails" do
      VCR.use_cassette("recipients-list-endpoint") do
        # call method you intend to use
        expect {Recipient.send_message("https://slack.com/api/bogus.endpoint")}.must_raise SlackAPIError
      end
    end
  end
end