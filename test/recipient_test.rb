require_relative "test_helper"

describe 'Recipient class' do
  describe 'attributes' do
    it 'should make a new instance of Recipient' do

    end
  end

  describe 'get method can get information from a provided url and params' do
    it 'gets channels.list' do
      VCR.use_cassette("channels") do
        params = {
          token: ENV["SLACK_TOKEN"]
        }
        response = Recipient.get("https://slack.com/api/channels.list", params)

        expect(response.code).must_equal 200
      end
    end
  end
end