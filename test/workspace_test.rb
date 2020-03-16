require_relative "test_helper"
require_relative '../lib/workspace'

describe "Workspace" do
  describe "Initialize" do
    before do
      VCR.use_cassette("create_workspace") do
        @workspace = Workspace.new
      end
    end

    it "will create a new Workplace" do
      expect(@workspace).must_be_instance_of Workspace
    end

    it "will have an array of Channels and Users" do
      expect(@workspace.channels).must_be_instance_of Array
      expect(@workspace.users).must_be_instance_of Array
    end

  end
end  


=begin 
describe "User" do
  describe "self.get" do
    it "gets a list of users and returns them as an HTTParty Response" do
      result = {}
      VCR.use_cassette("users-list-endpoint") do
        result = User.get("https://slack.com/api/users.list")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error when a call fails" do
      VCR.use_cassette("users-list-endpoint") do
        expect{result = User.get("https://slack.com/api/bogus.endpoint")}.must_raise SlackAPIError
      end
    end
  end

  describe "self.list" do
    it "return a valid list of the users" do
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
=end