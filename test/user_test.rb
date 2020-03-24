require_relative "test_helper"
require_relative "../lib/user"

describe "user" do

  before do 
    member = {"id"=>"USLACKBOT", "team_id"=>"TV5H57Z7E", "name"=>"slackbot", "deleted"=>false, "color"=>"757575", "real_name"=>"Slackbot",}
    @user = Slack::User.new(member)
  end

  describe "initialize" do
    it "raises an exception when trying to create a User with bad parameters" do
      expect{(Slack::User.new({"pie": "pumpkin"}))}.must_raise ArgumentError
    end

    it "creates a User object" do
      expect(@user).must_be_kind_of Slack::User
    end

    it "returns a slack id" do
      expect(@user.id).must_equal "USLACKBOT"
    end

    it "returns a username" do
      expect(@user.user_name).must_equal "slackbot"
    end

    it "returns a real name" do
      expect(@user.real_name).must_equal "Slackbot"
    end
  end

  describe "self.get_all" do
    it "successfully receives a response from the users.list endpoint" do
      VCR.use_cassette("users_list_endpoint") do
        users = Slack::User.get_all
        expect(users).must_be_kind_of Array
        expect(users.length > 0).must_equal true
      end
    end

    it "raises an argument when users.list endpoint struggles" do
      # VCR.use_cassette("users_list_endpoint_failure") do
      #   expect{(Slack::User.get_all)}.must_raise Slack::BadResponseError
      # end
    end

  end

  describe "self.list_all" do
        it "raises an argument when users.list endpoint struggles" do
      # VCR.use_cassette("users_list_endpoint_failure") do
      #   expect{(Slack::User.get_all)}.must_raise Slack::BadResponseError
      # end
    end
    it "successfully converts data in User objects" do

        VCR.use_cassette("users_list_endpoint") do
          results = Slack::User.list_all
          expect(results).must_be_kind_of Array
          expect(results.all? { |result| result.class == Slack::User } ).must_equal true
        end

    end
  end
end