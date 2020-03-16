require_relative "test_helper"
require_relative "../lib/user"

describe "User" do
  describe "initialize" do 
  end

  describe "self.get" do # inherited from recipient 
    it "gets a list of users" do 
      result = {}
      VCR.use_cassette("users-list-endpoint") do 
        result = User.get("https://slack.com/api/users.list")
      end 

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true # ensure its not a false positive response 
    end 

    it "raises an error when a call fails" do 
      VCR.use_cassette("users-list-endpoint") do 
        expect{ User.get("https://slack.com/api/bogus.endpoint") }.must_raise SlackAPIError
      end 
    end 
  end 

  describe "self.list" do 
    it "returns a valid list of users" do 
      result = []

      VCR.use_cassette("users-list-endpoint") do 
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