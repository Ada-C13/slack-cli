require_relative "test_helper"
require_relative "../lib/user"

describe "User" do
  describe "initialize" do
    before do
      @user = User.new("USLACKBOT", "slackbot", "Slackbot", "zenning out with tea", "🍵")
    end

    it "creates a new instance of User" do
      expect(@user).must_be_kind_of User
      expect(@user).must_respond_to :slack_id
      expect(@user).must_respond_to :name
      expect(@user).must_respond_to :real_name
      expect(@user).must_respond_to :status_text
      expect(@user).must_respond_to :status_emoji
    end

    it "stores an id" do
      expect(@user.slack_id).must_equal "USLACKBOT"
    end

    it "stores the user's name" do
      expect(@user.name).must_equal "slackbot"
    end

    it "stores the user's real name" do
      expect(@user.real_name).must_equal "Slackbot"
    end

    it "stores the user's status text" do
      expect(@user.status_text).must_equal "zenning out with tea"
    end

    it "stores the user's status emoji" do
      expect(@user.status_emoji).must_equal "🍵"
    end
  end

  describe "self.get_all" do
    it "gets a list of users and returns them as an HTTParty Response" do
      result = {}
      VCR.use_cassette("users-list-endpoint") do
        result = User.get_all("users.list")
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
