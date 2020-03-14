require_relative "test_helper"

describe "User" do
  describe "self.get" do
    before do
      VCR.use_cassette("user_uses_self.get") do
        @url = "https://slack.com/api/users.list"
        @response = User.get(@url)
      end
    end
    it "Uses self.get from the Recipient to get User object containing information about user profile" do
      expect(@response).must_be_instance_of HTTParty::Response
      expect(@response.code).must_equal 200
      expect(@response["ok"]).must_equal true
    end
    it "Should raise an Exception when the API call fails" do
      url = ""
      expect { User.get(url) }.must_raise Exception
    end
  end
  describe "list_all" do
    before do
      VCR.use_cassette("list_all_users") do
        @user_list = User.list_all
      end
    end
    it "Should return an array of User objects" do
      expect(@user_list).must_be_kind_of Array
      expect(@user_list.length).must_be :>, 0
      @user_list.each do |user|
        expect(user).must_be_instance_of User
      end
    end
  end
  #TODO need to test for the details method
end
