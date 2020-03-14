require_relative 'test_helper'
require "./lib/user"

describe "User" do
  describe "details" do
  end  

  describe "self.get" do
    it "gets a list of users" do
      result = {}
      VCR.use_cassette("users-list") do
        result = User.get("users.list")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error when the call fails" do
      VCR.use_cassette("users-list-fail") do
        expect{User.get("usersfail.list")}.must_raise SlackApiError
      end
    end
  end

  describe "self.list_all" do
    it "returns a list all users" do
      VCR.use_cassette("user-details") do
        response = User.list_all
        response.each do |user|
          expect(user).must_be_kind_of User
          expect(user).must_respond_to :slack_id
        end
      end
    end  
  end
end
