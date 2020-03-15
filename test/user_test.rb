require_relative 'test_helper'

describe "User" do

  describe "self.get" do
    it "gets a list of users and returns them as a HTTParty response" do
      result = {}
      VCR.use_cassette("users_list_endpoint") do
        result = User.get("https://slack.com/api/users.list",{
          token: ENV['SLACK_TOKEN'],
          pretty: 1
        })
      end
      expect(result).must_be_instance_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error when a call fails" do
      VCR.use_cassette("users_list_endpoint") do
        expect {User.get("https://slack.com/api/bogus.endpoint",{ token: ENV['SLACK_TOKEN'] })}.must_raise SlackAPIError
      end
    end

    it "raises and error with invalid params" do
      VCR.use_cassette("users_list_endpoint") do
        expect {User.get("https://slack.com/api/users.list", { token: "blah blah blah" })}.must_raise SlackAPIError
      end
    end
  end

  describe "self.list" do
    it "returns a valid list of users" do
      result = []
      VCR.use_cassette("users_list_endpoint") do
        result = User.list_all
      end

      expect(result).must_be_kind_of Array
      expect(result.length).must_be :>, 0
      result.each do |user|
        expect(user).must_be_kind_of User
      end
    end
  end
  
end