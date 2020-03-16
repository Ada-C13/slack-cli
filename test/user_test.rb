require_relative "test_helper"
require_relative "../lib/user"

describe "User class" do
  describe "User instantiation" do

    before do
      base_url = "https://slack.com/api/"
      @post_url = "#{base_url}users.list"
      @params = { token: ENV["SLACK_API_TOKEN"] }
    end
    
    it "can get the list of users" do
      result = {}
      VCR.use_cassette("users-list-endpoint") do
      result = Slack_cli::User.get(@post_url, @params)
      end
      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "throws an argument error when a call fails" do
      VCR.use_cassette("users-list-endpoint") do
        expect{Slack_cli::User.get("https://slack.com/api/bogus.list",@params)}.must_raise SlackAPIError
      end
    end
    
    it "List of valid users" do
      response = []

      VCR.use_cassette("users-list-endpoint") do
        response = Slack_cli::User.list_all
      end

      expect(response).must_be_kind_of Array
      expect(response.length).must_be :>, 0

      response.each do |resp|
        expect(resp).must_be_kind_of Slack_cli::User
      end

    end
  end
end
