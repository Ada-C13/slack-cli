require_relative 'test_helper'

describe "User" do
  describe ".list_all" do
    it "Can list users" do
      VCR.use_cassette("list_users") do
        users = User.list_all
        expect(users).wont_be_nil
        expect(users.length > 0).must_equal true
        users.each do |user|
          expect(user.slack_id).must_be_kind_of String
        end
      end
    end
  end
end