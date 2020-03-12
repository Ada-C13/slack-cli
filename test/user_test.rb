require_relative 'test_helper'

describe "User" do
  describe ".list_all" do
    it "Can list users" do
      VCR.use_cassette("list_users") do
        users = User.list_all
        expect(users).wont_be_nil
        expect(users.length > 0).must_equal true
      end
    end
  end
end