require_relative "test_helper"
require_relative "../lib/user"

describe "User" do
  describe "self.get_all" do
    it "gets a list of users and returns them as an HTTParty Response" do
      result = {}
      VCR.use_cassette("users-list-endpoint") do
        result = User.get_all("https://slack.com/api/users.list")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error when a call to users-list-endpoint fails" do
      VCR.use_cassette("users-list-endpoint") do
        expect { User.get_all("https://slack.com/api/bogus.endpoint") }.must_raise SlackAPIError
      end
    end
  end

  describe "self.list_users" do
    it "returns a valid list of the users" do
      result = []

      VCR.use_cassette("users-list-endpoint") do
        result = User.list_users
      end

      expect(result).must_be_kind_of Array
      expect(result.length).must_be :>, 0
      result.each do |user|
        expect(user).must_be_kind_of User
      end
    end
  end
end
