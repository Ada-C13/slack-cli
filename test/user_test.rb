require_relative "test_helper"

describe User do
  describe "self.list_all method" do
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

  describe "self.get" do
    it "gets a list of users and returns than as an HTTParty response" do
      response = {}
      VCR.use_cassette("list_of_users") do
        response = User.get("https://slack.com/api/users.list")
      end
      expect(response).must_be_kind_of HTTParty::Response
      expect(response["ok"]).must_equal true
    end

    it "raises an error when a call fails" do
      VCR.use_cassette("list_of_users") do
        expect{User.get("https://slack.com/api/whatever")}.must_raise SlackAPIError
      end
    end
  end

  describe "details method" do
    it "lists slack_id, name, real_name, status_text, and status_emoji info of the user" do
      VCR.use_cassette("list_of_users") do
        response = User.get("https://slack.com/api/users.list")
        user_list = User.list_all
        user = user_list[0].details
        expect(user).must_equal "Slack ID: USLACKBOT\nName: slackbot\nReal Name: Slackbot\nStatus Text: \nStatus Emoji: "
      end
    end
  end
end