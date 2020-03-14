require_relative "test_helper"

describe User do
  describe "self.list_all method" do
    # from Devin's demo
    it "return a valid list of the users" do
      response = []
      VCR.use_cassette("list_of_users") do
        response = User.list_all
      end

      expect(response).must_be_kind_of Array
      expect(response.length).must_be :>, 0 
      response.each do |user|
        expect(user).must_be_kind_of User
      end
    end

    it "must include slackbot in the user lists" do
      VCR.use_cassette("list_of_users") do
        response = User.list_all
        expect(response[0].slack_id).must_equal "USLACKBOT"
      end
    end
  end

  # from Devin's demo
  describe "self.get" do
    it "gets a list of users and returns than as an HTTParty response" do
      result = {}
      VCR.use_cassette("list_of_users") do
        result = User.get("https://slack.com/api/users.list")
      end
      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error when a call fails" do
      VCR.use_cassette("list_of_users") do
        expect{User.get("https://slack.com/api/whatever")}.must_raise SlackAPIError
      end
    end
  end
end