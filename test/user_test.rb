require_relative 'test_helper'
require "./lib/user"

describe "User" do
  describe "details" do
    it "returns table of data" do
      user = User.new("123456", "Bobbert", "Robert", "Hi", ":)")
      expect(user.details).must_be_kind_of TablePrint::Returnable
    end
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

  describe "send_message" do
    it "sends a message to the correct user" do
      VCR.use_cassette("send-message") do
        user = User.list_all[0]
        response = user.send_message("the test message")
        expect(response).must_equal true
      end
    end

    it "raises SlackApiError if post request fails" do
      VCR.use_cassette("send-message") do
        user = User.new("bogus", "bogus_info", "bogus", "bogus", "bogus")
        expect{user.send_message("the test message")}.must_raise SlackApiError
      end
    end
  end
end
