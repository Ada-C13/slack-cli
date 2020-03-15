require_relative 'test_helper'

describe "User" do
  describe ".list_all" do
    it "Can list users" do
      VCR.use_cassette("list_users") do
        users = User.list_all
        expect(users).wont_be_nil
        expect(users.length > 0).must_equal true
        users.each do |user|
          expect(user.slack_id).must_be_kind_of String
        end
      end
    end
  end

  describe "self.get" do
    it "gets a list of users and returns them as HTTParty Response object" do
      VCR.use_cassette("list_users") do
        result = User.get("https://slack.com/api/users.list")
        expect(result).must_be_kind_of HTTParty::Response
        expect(result["ok"]).must_equal true
        expect(result["members"]).must_be_kind_of Array

      end
    end

    it "raises an error when a call fails" do
      VCR.use_cassette("list_users") do
        expect{
          User.get("https://slack.com/api/users.listik")
        }.must_raise SlackApiError
      end
    end
  end
end
