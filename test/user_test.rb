require_relative "test_helper"
require_relative "../lib/user"

describe "User" do
  describe "initialize" do
    it "instance of user class" do
      expect(@real_name).must_be_kind_of User
      expect(@status_text).must_be_kind_of User
      expect(@status_emoji).must_be_kind_of User
    end
  end
  describe "self.get" do
    it "gets list of users" do
      result = {}
      VCR.use_cassette("users-list-endpoint") do
        result = User.get("https://slack.com/api/users.list")
      end
      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error if call fails" do
      VCR.use_cassette("users-list-endpoint") do
        expect {User.get("https://slack.com/api/bogus.endpoint")}.must_raise SlackAPIError
      end
    end
  end
end