require_relative "test_helper"
require_relative "../lib/user"

describe "User" do
  before do
    @real_name = "Real Name"
    @status_text = "busy"
    @slack_id = "RN123"
    @user = User.new(real_name: @real_name, status_text: @status_text, status_emoji: @status_emoji, slack_id: @slack_id, name: @name)
  end

  describe "constructor" do
    it "instance of user class" do
      expect (@user).must_be_instance_of User
    end
    it "can access attributes"do
      expect(@real_name).must_equal @real_name
      expect(@status_text).must_equal @status_text
      expect(@slack_id).must_equal @slack_id
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