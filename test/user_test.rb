require_relative "test_helper"
require_relative "../lib/user"

describe "user" do
  describe "initialize" do
    before do 
      test_member = 
      {
        "id": "UV614256C",
        "team_id": "TV5H57Z7E",
        "name": "angethuy",
        "is_bot": false,
        "color": "9f69e7",
        "real_name": "Angela",
      }
      user = User.new(test_member)
    end

    it "raises an exception when trying to create a User with bad parameters" do
      expect{(User.new("pumpkin pie"))}.must_raise ArgumentError
    end

    it "creates a User object" do
      expect(user).is_kind_of? Slack::User
    end

    it "returns a slack id" do
      expect(user.id).must_equal "UV614256C"
    end

    it "returns a username" do
      expect(user.name).must_equal "angethuy"
    end

    it "returns a real name" do
      expect(user.real_name).must_equal "Angela"
    end
  end

  describe "self.get_all" do
    # raise exception for bad endpoint response
    # API endpoint https://slack.com/api/users.list?
    it "successfully receives a response from the users.list endpoint" do
      users = {}
      VCR.use_cassette(users_list_endpoint) do
        users = User.get_all
      end

      expect(users)
    end
  end

  describe "self.list_all" do
    # one of the users must be as expected 
  end
end