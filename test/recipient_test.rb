require_relative "test_helper"

describe 'Recipient class' do
  describe 'get method can get information from a provided url' do
    it 'gets channels.list' do
      VCR.use_cassette("channels") do
        params = {
          token: ENV["SLACK_TOKEN"]
        }
        response = Recipient.get("https://slack.com/api/channels.list")

        expect(response["ok"]).must_equal true
        expect(response["channels"].length).must_equal 3
        expect(response["channels"][0]).must_include "id"
      end
    end

    it 'gets users.list' do
      VCR.use_cassette("users") do
        params = {
          token: ENV["SLACK_TOKEN"]
        }
        response = Recipient.get("https://slack.com/api/users.list")
        p response
        expect(response["ok"]).must_equal true
        expect(response["members"].length).must_equal 10
        expect(response["members"][0]).must_include "id"
      end
    end
  end
end