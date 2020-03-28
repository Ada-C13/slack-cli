require_relative 'test_helper'
require_relative '../lib/user'
####test initialize
describe "User" do
  describe "initialize" do
    before do
      @user = User.new(slack_id: "USLACKBOT", name: "slackbot", real_name: "Slackbot", status_text: "", status_emoji: "")
    end

    it "is an instance of User" do
      expect(@user).must_be_kind_of User
    end
  end
    describe "details" do
      before do
        @user = User.new(slack_id: "USLACKBOT", name: "slackbot", real_name: "Slackbot", status_text: "", status_emoji: "")
      end
    it "returns user details" do
    expect(@user.details).must_equal "Slack ID: #{@user.slack_id}, Name: #{@user.name}, Real Name: #{@user.real_name}, Status Text: #{@user.status_text}, Status Emoji: #{@user.status_emoji}"
  end
end

  describe "self.get" do
    it "gets a list of users" do
      result = {}
      VCR.use_cassette("users-list-endpoint") do
        result = User.get("https://slack.com/api/users.list")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error when a call fails" do
      VCR.use_cassette("user-list-endpoint") do
        expect {User.get("https://slack.com/api/bogus.endpoint")}.must_raise SlackAPIError
      end
    end
  end

  describe "self.list" do
    it "returns a valid list of users" do
      result = []

      VCR.use_cassette('users-list-endpoint') do
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