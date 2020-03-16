# Recipient_test.rb
require_relative 'test_helper'
require_relative  '../lib/recipient'


describe "Recipient" do

  before do
    @recipient = Slack_cli::Recipient.new(
      id: 1,
      name: "Test Test",
    )
  end

  it "is an instance of Channel" do
    expect(@recipient).must_be_kind_of Slack_cli::Recipient
  end

  it "can get a valid information from the API" do
    VCR.use_cassette("recipient-recipients") do

      base_url = "https://slack.com/api/"
      post_url = "#{base_url}channels.list"
      params = { token: ENV["SLACK_API_TOKEN"] }

      resp = Slack_cli::Recipient.get(base_url, params)
     
      expect(resp.code == 200 && resp.parsed_response["ok"]).must_equal "ok"
    end
  end

  it "raises an error if invoked list_all directly (without subclassing)" do
    expect { Slack_cli::Recipient.list_all }.must_raise NotImplementedError
  end

  it "raises an error if invoked details directly (without subclassing)" do
    expect { @recipient.details }.must_raise NotImplementedError
  end
end