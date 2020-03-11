require_relative "test_helper"

describe User do
  describe "self.list_all method" do
    it "list out all the users info by calling self.list_all" do
      VCR.use_cassette("list_of_users") do
        response = User.list_all
        expect(response.length).must_equal 11 
      end
    end
  end
end